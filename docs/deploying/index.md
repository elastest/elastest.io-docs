<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Deploying ElasTest</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h2 class="h3 no-border">Cloud Formation</h2>

The easiest way to deploy ElasTest is by using our Amazon CloudFormation template. In a few steps by clicking a couple of buttons you will have your ElasTest ready to go. If you don't have an AWS account you will need one (follow those [steps](http://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/AboutAWSAccounts.html) to get it).

1) Go to [AWS CloudFormation Pane](https://eu-west-1.console.aws.amazon.com/cloudformation/) and create a **new stack**.

2) Select option "Choose a template" and use [this JSON file](https://raw.githubusercontent.com/elastest/elastest-toolbox/master/AWS/cloud-formation-latest.json).

3) Complete the form shown on the next step with the following information:

| Parameter | Value | Details | Ready? |
| --- | --- | --- | --- |
| Stack name | The name of the stack | Elastest is OK | yes |
| ElastestCertificateType | _selfsigned_, _letsencrypt_ or _owncert_ | You can choose which type of certificate use with elastest | no |
| ElastestExecutionMode | _normal_, _experimental-lite_ or _experimental_ | Choose Elastest execution mode | yes |
| ElastestPassword | Your password | Password to access the platform | no |
| ElastestUsername | Your username | Username to access the platform | no |
| ElastestVersion | _latest_ | which version of elastest do you want to launch | yes |
| InstanceType | The type of machine you want (recommended at least _m4.large_) | Elastest needs resources to run, please be genereous | yes |
| KeyName | One of your AWS keys | RSA key to access the instance through SSH | yes |
| LetsEncryptEmail | Your email | Email to recive Let's Encrypt notifications | no |
| OwnCertCRT | Your _.crt_ file content (if _owncert_ on _ElastestCertificateType_) | The certificate chain | no |
| OwnCertKEY | Your _.key_ file content (if _owncert_ on _ElastestCertificateType_) | The private key | no |
| SwapSize | 4 | The amount of swap memory in GB | yes |

4) Accept next steps and finally deploy your stack.

When the stack has finished the deployment, you can check *Output* tab at the bottom of your Stacks page to see the URL to access your ElasTest dashboard.

<h2 class="h3 no-border">Native deployment: Docker</h2>

#### Introduction

Through the following lines you will find a guide to deploy Elastest on a single machine (physical or virtual). So the same steps can be applied to a server on your data center or an instance on AWS, OpenStack, Azure or Google Cloud.

You only need remote or physical access to an **Ubuntu 16.04** interactive shell to run commands as a privilegiated user.

#### Accesing the instance

Depends on your infraestructure the access will be different. Please, refer to your system administrator to know how to grant access to the console.

#### Swap space

Elastest needs some swap space. If your server is physical, it probably has some space already. You can check by running:

```
$ free -m
```

And you should see something like:

```
              total        used        free      shared  buff/cache   available
Mem:          15921        5059        5278        1130        5582        9337
Swap:           975           0         975
```

The line labeled as *swap* shows the swap space. When you have no swap space, it shows this:


```
              total        used        free      shared  buff/cache   available
Mem:          15921        5059        5278        1130        5582        9337
Swap:             0           0           0
```

If you're working on the cloud, you'll probably need to add some swap space. To do that follow this steps:

##### 1. Creating a swap file

```
$ sudo fallocate -l 4G /swapfile
```

This command will create a 4G file in / called swapfile. You can check it by doing:

```
$ ls -lh /swapfile
```

Now, set up the proper file permissions:

```
$ sudo chmod 0600 /swapfile
```

##### 2. Mark the file as swap space

```
$ sudo mkswap /swapfile
```

##### 3. Activate the swap

```
$ sudo swapon /swapfile
```

##### 4. Checking

If you run the *free* command again you'll see the swap space available.

```
$ free -m
```

##### 5. Making changes permanent

To make those changes permanent, add the following line to your */etc/fstab* file:

```
/swapfile  none wap sw 0 0
```

#### The *vm.max_map_count* issue

According to Elasticsearch docs, you need to set up *vm.max_map_count* to an upper value in production environments. Check [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html) if you need more information.

So, to increase that kernel parameter just do:

```
$ sudo sysctl -w vm.max_map_count=262144
```

To make changes permanent,

```
$ sudo echo vm.max_map_count=262144 >> /etc/sysctl.conf
```

#### Running Elastest on system boot

There isn't an easy way to run Elastest with the system, but there's a few tips you can considerate.

##### Removing all volumes

We recommend to remove all the volumes except the MySQL one, because is the one who maintain the test data.

To do so.

```
$ for volume in $(docker volume ls | grep -v mysql | tail -n +2 | awk '{print $2}'); do docker volume rm $volume; done
```

##### Removing all containers

To remove all the containers:

```
$ docker rm -f $(docker ps -a -q)
```

##### Putting all the pieces together

We provide a set of scripts to achive this.

**1) Clean all containers and volumes (`/usr/local/bin/docker-evacuate`)**

```
#!/bin/bash

# Delete all containers
docker rm -f $(docker ps -a -q)

for volume in $(docker volume ls | grep -v mysql | tail -n +2 | awk '{print $2}')
do
  docker volume rm $volume
done
```

Set execution permissions:

```
$ chmod 0755 /usr/local/bin/docker-evacuate
```

**2) Start Elastest (`/usr/local/bin/docker-elastest-up`)**

```
#!/bin/bash
docker run -d -v /var/run/docker.sock:/var/run/docker.sock elastest/platform:latest start --server-address=YOU_IP_HERE --mode=MODE --pullcore
```

Remember to complete the *server-address* and *mode* parameters. You can run this command:

```
$ docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --help
```

to get information.

Set execution permissions:

```
$ chmod 0755 /usr/local/bin/docker-elastest-up
```

**3) Systemd start script (`/etc/systemd/system/docker-elastest.service`)**

```
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

```
$ sudo systemctl daemon-reload
```

Enable the service to start with the system

```
$ sudo systemctl enable docker-elastest
```
