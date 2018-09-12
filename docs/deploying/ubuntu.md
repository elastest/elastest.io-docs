<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Deploying ElasTest on a Linux server</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Introduction</h4>

Through the following lines you will find a guide to deploy Elastest on a single machine (physical or virtual). So the same steps can be applied to a server on your data center or an instance on AWS, OpenStack, Azure or Google Cloud.

We've tried to deploy Elastest on **Ubuntu 16.04** and **CentOS 7** and the steps are basically the same.

You only need remote or physical access to a **Linux** interactive shell to run commands as a privilegiated user.

<h4 class="holder-subtitle link-top">Accesing the instance</h4>

Depends on your infraestructure the access will be different. Please, refer to your system administrator to know how to grant access to the console.

<h4 class="holder-subtitle link-top">Installing Docker</h4>

First of all, you'll need to install Docker, please, refer to the official documentation to install onto your platform:

[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

[Centos](https://docs.docker.com/install/linux/docker-ce/centos/)

If you want to use docker with a regular user add the user to _docker_ group:

```bash
sudo usermod -aG docker YOUR_USER
```

<h4 class="holder-subtitle link-top">Swap space</h4>

Elastest needs some swap space. If your server is physical, it probably has some space already. You can check by running:

```bash
free -m
```

And you should see something like:

```text
              total        used        free      shared  buff/cache   available
Mem:          15921        5059        5278        1130        5582        9337
Swap:           975           0         975
```

The line labeled as *swap* shows the swap space. When you have no swap space, it shows this:


```text
              total        used        free      shared  buff/cache   available
Mem:          15921        5059        5278        1130        5582        9337
Swap:             0           0           0
```

If you're working on the cloud, you'll probably need to add some swap space. To do that follow this steps:

<h6 class="small-subtitle">1) Creating a swap file</h6>

With Ubuntu:

```bash
sudo fallocate -l 4G /swapfile
```

With Centos:

```bash
sudo dd if=/dev/zero of=/swapfile count=4096 bs=1MiB
```

Both commands will create a 4G file in / called swapfile. You can check it by doing:

```bash
ls -lh /swapfile
```

Now, set up the proper file permissions:

```bash
sudo chmod 0600 /swapfile
```

<h6 class="small-subtitle">2) Mark the file as swap space</h6>

```bash
sudo mkswap /swapfile
```

<h6 class="small-subtitle">3) Activate the swap</h6>

```bash
sudo swapon /swapfile
```

<h6 class="small-subtitle">4) Checking</h6>

If you run the *free* command again you'll see the swap space available.

```bash
free -m
```

<h6 class="small-subtitle">5) Making changes permanent</h6>

To make those changes permanent, add the following line to your */etc/fstab* file:

```bash
sudo echo "/swapfile none swap sw 0 0" >> /etc/fstab
```

<h4 class="holder-subtitle link-top">The <i>vm.max_map_count</i> issue</h4>

According to Elasticsearch docs, you need to set up *vm.max_map_count* to an upper value in production environments. Check [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html) if you need more information.

So, to increase that kernel parameter just do:

```bash
sudo sysctl -w vm.max_map_count=262144
```

To make changes permanent,

```bash
sudo echo vm.max_map_count=262144 >> /etc/sysctl.conf
```

<h4 class="holder-subtitle link-top">Launching Elastest</h4>

In order to launch Elastest platform just type

```bash
docker run -ti \
  --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  elastest/platform start \
  --mode normal \
  --server-address=X.Y.Z.W \
  -tl \
  --user=elastest \
  --password=elastest
```

Elastest needs to use Docker to launch other containers, so we bind the socket as a volume inside the platform.

We can choose the execution mode _normal_, _experimental_, _experimental_lite_

The **server-address** is web address you will reach the platform. If you're deploying on a cloud provider (like AWS, GCE o Azure) this address should be your public IP, if you're deploying on your private LAN this is the address you're using to connect the server. Finally, if you're deploying on your laptop then you can omit the parameter.

Alternatively, you can use a domain name like **elastest.my_company.com** for the _server_address_ parameter.

_-tl_ stands for TestLink.

Finally, set user and password to grant access to the platform. You can omit this parameters if you're working on a safe evironment.

Type 

```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --help
```

to get more information.

You'll see the following lines on the terminal when the platform is up and ready

```text
Starting ElasTest Platform (normal mode)...

Please wait a few seconds while we start the ElasTest services, the ElasTest URL will be shown when ready.

ElasTest Platform is available at http://X.Y.Z.W:37000
```

It'll show the domain name instead the IP address in the case you're using a DNS service.

<h4 class="holder-subtitle link-top">Running Elastest on system boot</h4>

Elastest needs two script and a Systemd unit to work on system boot. 

<h6 class="smaller-subtitle">1) Clean all containers and volumes (<code>/usr/local/bin/docker-evacuate</code>)</h6>

The first script is `docker-evacuate` and will clean the platform from the system. Basically, it'll remove unnecessary Docker' volumes and containers.

```bash
#!/bin/bash

# Delete all containers
docker rm -f $(docker ps -a -q)

for volume in $(sudo docker volume ls | grep -v elastest_edm-mysql | grep -v elastest_elasticsearch-data | grep -v elastest_etm-testlink | tail -n +2 | awk '{print $2}')
do
  sudo docker volume rm $volume 
done
```

The volumes listed are kept because they contain user data like the metrics, tests, etc.

Set execution permissions:

```bash
sudo chmod 0755 /usr/local/bin/docker-evacuate
```

<h6 class="smaller-subtitle">2) Start Elastest (<code>/usr/local/bin/docker-elastest-up</code>)</h6>

This script will launch elastest and contains the following lines:

```bash
#!/bin/bash
PUBLIC_IP=$(curl ifconfig.co)
nohup docker run -d -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=${PUBLIC_IP} --mode=normal --pullcore &>/dev/null &
disown

exit 0
```

As you can see, we set less parameters here as the initial configuration was made on the first launch.

We use an external service like [ifconfig.co](http://ifconfig.co) to get the external IP on every lunch. This works fine on a cloud provider who give the instance a diferent IP on every boot, nevertheless, if you're using a static IP or a DNS name feel free to change the parameter.

Set execution permissions:

```bash
sudo chmod 0755 /usr/local/bin/docker-elastest-up
```

<h6 class="smaller-subtitle">3) Systemd start script (<code>/etc/systemd/system/docker-elastest.service</code>)</h6>

```text
[Unit]
Description=Elastest Platform
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=60
Restart=always
ExecStop=/usr/local/bin/docker-evacuate
ExecStart=/usr/local/bin/docker-elastest-up
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Reload systemd daemon:

```bash
sudo systemctl daemon-reload
```

Enable the service to start with the system

```bash
sudo systemctl enable docker-elastest
```

<h6 class="smaller-subtitle">Start and Stop Elastest</h6>

From now on, everytime you want to launch Elastest:

```bash
sudo systemctl start docker-elastest
```

or stop

```bash
sudo systemctl stop docker-elastest
```

