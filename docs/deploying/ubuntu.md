<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Deploying ElasTest on a Linux server</h2>
</div>
</div>

<h3 class="holder-subtitle link-top">Introduction</h3>

Through the following lines you will find a guide to deploy ElasTest on a single machine (physical or virtual). So the same steps can be applied to a server on your data center or an instance on AWS, OpenStack, Azure or Google Cloud.

We've tried to deploy ElasTest on **Ubuntu 16.04**, **Ubuntu 18.04** and **CentOS 7** and the steps are basically the same.

You only need remote or physical access to a **Linux** interactive shell to run commands as a privilegiated user.

You can also deploy ElasTest on <a href="/docs/deploying/aws/">Amazon Web Services</a>

<h3 class="holder-subtitle link-top">Accesing the instance</h3>

Depends on your infraestructure the access will be different. Please, refer to your system administrator to know how to grant access to the console.

In order to Elastest to work properly, some ports must be open:

| Port/s | Comment |
| ------ | ------- |
| 22     | SSH |
| 32768 - 61000 | ElastestRange |

**Note**: All ports are TCP.

<h3 class="holder-subtitle link-top">Installing Docker</h3>

First of all, you'll need to install Docker, please, refer to the official documentation to install onto your platform:

[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

[Centos](https://docs.docker.com/install/linux/docker-ce/centos/)

If you want to use docker with a regular user add the user to _docker_ group:

```bash
sudo usermod -aG docker YOUR_USER
```

<h3 class="holder-subtitle link-top">Launching ElasTest</h3>

In order to launch ElasTest platform just type

```bash
docker run -ti \
  --rm \
  -v ~/.elastest:/data \
  -v /var/run/docker.sock:/var/run/docker.sock \
  elastest/platform start \
  --server-address=X.Y.Z.W \
  --testlink \
  --jenkins \
  --user=xxxxxx \
  --password=yyyyyy
```

ElasTest needs to use Docker to launch other containers, so we bind the socket as a volume inside the platform.

The **server-address** is web address you will reach the platform. If you're deploying on a cloud provider (like AWS, GCE o Azure) this address should be your public IP, if you're deploying on your private LAN this is the address you're using to connect the server.It's necessary to use the **`--server-address`** option and also open all ports from **`32768 to 61000`** both included. It is highly recommended to also set user and password using the **`--user`** and **`--pass`** options.

Alternatively, you can use a domain name like **elastest.my_company.com** for the _server_address_ parameter.

**`--testlink`** stands for TestLink and **`--jenkins`** stands for Jenkins. These fields are not obligatory but its use is **recommended**. 

You can also use your own Jenkins and install the <a href="/docs/jenkins/">ElasTest plugin for Jenkins</a>

Finally, set user and password to grant access to the platform. You can omit this parameters if you're working on a safe evironment.

You'll see the following lines on the terminal when the platform is up and ready

```text
Pulling some necessary images...

Preload images finished.

Starting ElasTest Platform latest (normal Mode)...

Creating volume "elastest_platform-services" with local driver
Creating elastest_platform-services_1 ... done
Creating elastest_edm-mysql_1         ... done
Creating elastest_etm-filebeat_1      ... done
Creating elastest_etm-jenkins_1       ... done
Creating elastest_etm-testlink_1      ... done
Creating elastest_etm_1               ... done
Creating elastest_etm-proxy_1         ... done

ElasTest services are starting. This will likely take some time. The ElasTest URL will be shown when ready.


ElasTest Platform is available at http://W.X.Y.Z:37000

Press Ctrl+C to stop.
```

It'll show the domain name instead the IP address in the case you're using a DNS service.

Type the following command to get more information about start command:

```bash
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --help
```

<!-- OPTIONS -->

<h4 class="small-subtitle">Options</h4>

You can include the option **`--server-address=(docker-machine ip)`** to set up the machine ip address.

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address="myip"
```

You can set an access username and password using the options **`--user`** and **`--pass`** (or **`-u`** and **`-p`**)

```
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --user=elastest --password=elastest
```

You can add **`--testlink`** if you want to start the TestLink integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --testlink
```

The **`--jenkins`** option can be added if you want to start the Jenkins integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --jenkins
```

You can execute **`--help`** if you need more information about the options.

```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform --help
```

<h3 class="holder-subtitle link-top">Running ElasTest on system boot</h3>

To start ElasTest automatically on a system with Systemd, two scripts are needed:

<h4 class="small-subtitle">1) Start ElasTest (<code>/usr/local/bin/elastest-start</code>)</h4>

This script will launch elastest and contains the following lines:

```bash
#!/bin/bash
PUBLIC_IP=$(curl ifconfig.co)
nohup docker run -d -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=${PUBLIC_IP} &>/dev/null &
disown

exit 0
```

As you can see, we set less parameters here as the initial configuration was made on the first launch.

For --server-address, we use an external service like [ifconfig.co](http://ifconfig.co) to get the external IP on every launch using `curl`. This works fine on a cloud provider who give the instance a diferent IP on every boot, nevertheless, if you're using a static IP or a DNS name feel free to change the parameter.

Set execution permissions:

```bash
sudo chmod 0755 /usr/local/bin/elastest-start
```

<h4 class="small-subtitle">2) Stop ElasTest (<code>/usr/local/bin/elastest-stop</code>)</h4>

The second script is `elastest-stop` to stop ElasTest.

```bash
#!/bin/bash
docker run -d -v /var/run/docker.sock:/var/run/docker.sock elastest/platform stop
```

Set execution permissions:

```bash
sudo chmod 0755 /usr/local/bin/elastest-stop
```

<h4 class="small-subtitle">3) Systemd start script (<code>/etc/systemd/system/elastest.service</code>)</h4>

```text
[Unit]
Description=ElasTest Platform
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=60
Restart=always
ExecStop=/usr/local/bin/elastest-stop
ExecStart=/usr/local/bin/elastest-start
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
sudo systemctl enable elastest
```

<h4 class="small-subtitle">Start and Stop ElasTest</h4>

From now on, everytime you want to launch ElasTest:

```bash
sudo systemctl start elastest
```

or stop

```bash
sudo systemctl stop elastest
```

<h3 class="holder-subtitle link-top">Swap space</h3>

It is possible that elastest needs some swap space. If your server is physical, it probably has some space already. You can check by running:

```bash
free -m
```

And you should see something like:

```text
              total        used        free      shared  buff/cache   available
Mem:          15921        5059        5278        1130        5582        9337
Swap:           975           0         975
```

The line labeled as _swap_ shows the swap space. When you have no swap space, it shows this:

```text
              total        used        free      shared  buff/cache   available
Mem:          15921        5059        5278        1130        5582        9337
Swap:             0           0           0
```

If you're working on the cloud, you'll probably need to add some swap space. To do that follow this steps:

<h4 class="small-subtitle">1) Creating a swap file</h4>

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

<h4 class="small-subtitle">2) Mark the file as swap space</h4>

```bash
sudo mkswap /swapfile
```

<h4 class="small-subtitle">3) Activate the swap</h4>

```bash
sudo swapon /swapfile
```

<h4 class="small-subtitle">4) Checking</h4>

If you run the _free_ command again you'll see the swap space available.

```bash
free -m
```

<h4 class="small-subtitle">5) Making changes permanent</h4>

To make those changes permanent, add the following line to your _/etc/fstab_ file:

```bash
sudo echo "/swapfile none swap sw 0 0" >> /etc/fstab
```

<h3 id="elastestData" class="holder-subtitle link-top">ElasTest data</h3>

ElasTest makes use of a folder and two volumes to store the data:

<h4 class="small-subtitle">/data folder</h4>

As you may have seen above in the ElasTest start command, two volumes are binded. The first one is the **`/data`** folder that, in the example commands, we have bind to the host's **`~/.elastest`** folder, but you can choose the host folder you want.

In this folder some data like the videos of the tests or configurations of Elastest are saved.

<h4 class="small-subtitle">elastest_edm-mysql volume</h4>
The **`elastest_edm-mysql`** volume contains the ElasTest database, which contains all the data information of the tests, such as projects, suts, monitoring traces, test results, etc.

<h4 class="small-subtitle">elastest_etm-testlink volume</h4>
The **`elastest_etm-testlink`** volume contains TestLink configuration information, such as the name of the MySql schema created in the database of **`elastest_edm-mysql`** volume.

<!---
 Script for open external links in a new tab
-->
<script type="text/javascript" charset="utf-8">
      // Creating custom :external selector
      $.expr[':'].external = function(obj){
          return !obj.href.match(/^mailto\:/)
                  && (obj.hostname != location.hostname);
      };
      $(function(){
        $('a:external').addClass('external');
        $(".external").attr('target','_blank');
      })
</script>
