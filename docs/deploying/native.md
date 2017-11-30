<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Deploying ElasTest from scratch</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Introduction</h4>

Through the following lines you will find a guide to deploy Elastest on a single machine (physical or virtual). So the same steps can be applied to a server on your data center or an instance on AWS, OpenStack, Azure or Google Cloud.

You only need remote or physical access to an **Ubuntu 16.04** interactive shell to run commands as a privilegiated user.

<h4 class="holder-subtitle link-top">Accesing the instance</h4>

Depends on your infraestructure the access will be different. Please, refer to your system administrator to know how to grant access to the console.

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

```bash
sudo fallocate -l 4G /swapfile
```

This command will create a 4G file in / called swapfile. You can check it by doing:

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

```text
/swapfile  none wap sw 0 0
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

<h4 class="holder-subtitle link-top">Running Elastest on system boot</h4>

There isn't an easy way to run Elastest with the system, but there's a few tips you can considerate.

<h6 class="small-subtitle">Removing all volumes</h6>

We recommend to remove all the volumes except the MySQL one, because is the one who maintain the test data.

To do so:

```bash
for volume in $(docker volume ls | grep -v mysql | tail -n +2 | awk '{print $2}'); do docker volume rm $volume; done
```

<h6 class="small-subtitle">Removing all containers</h6>

To remove all the containers:

```bash
docker rm -f $(docker ps -a -q)
```

<h6 class="small-subtitle">Putting all the pieces together</h6>

We provide a set of scripts to achive this:

<h6 class="smaller-subtitle">1) Clean all containers and volumes (<code>/usr/local/bin/docker-evacuate</code>)</h6>

```bash
#!/bin/bash

# Delete all containers
docker rm -f $(docker ps -a -q)

for volume in $(docker volume ls | grep -v mysql | tail -n +2 | awk '{print $2}')
do
  docker volume rm $volume
done
```

Set execution permissions:

```bash
chmod 0755 /usr/local/bin/docker-evacuate
```

<h6 class="smaller-subtitle">2) Start Elastest (<code>/usr/local/bin/docker-elastest-up</code>)</h6>

```bash
#!/bin/bash
docker run -d -v /var/run/docker.sock:/var/run/docker.sock elastest/platform:latest start --server-address=YOU_IP_HERE --mode=MODE --pullcore
```

Remember to complete the *server-address* and *mode* parameters. You can run this command:

```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --help
```

to get information.

Set execution permissions:

```bash
chmod 0755 /usr/local/bin/docker-elastest-up
```

<h6 class="smaller-subtitle">3) Systemd start script (<code>/etc/systemd/system/docker-elastest.service</code>)</h6>

```text
[Unit]
Description=Elastest Platform
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStop=/usr/local/bin/docker-evacuate
ExecStart=/usr/local/bin/docker-elastest-up

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
