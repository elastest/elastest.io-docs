<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Try ElasTest</h2>
</div>
</div>

<!-- FOR LINUX -->
<h4 class="holder-subtitle link-top">For Linux</h4>

ElasTest is based on <strong>Docker</strong> technology. To execute ElasTest you need Docker CE installed on your machine following the official instructions for <a href="https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/" target="_blank">Ubuntu</a>.

Once you have docker installed, execute the following command to start ElasTest:

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start
```

Whatever platform you are using, you will see this output when ElasTest is ready:

```text
Pulling some necessary images...

Preload images finished.

Starting ElasTest Platform (normal mode)...

ElasTest services are starting. This will likely take some time. The ElasTest URL will be shown when ready.

ElasTest Platform is available at http://localhost:37000

Press Ctrl+C to stop.
```

You can then open in your web browser the shown URL to access to ElasTest dashboard.

To stop ElasTest, press **`Ctrl+C`** in the shell used to start it. Now you can try any of the test projects available by default when you start ElasTest. You can start with [Unit Tests](your-first-test) project.

<h5 class="small-subtitle">Options</h5>

The **`--logs`** option allows you to show all the containers logs.

```
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --logs
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


<h5 class="small-subtitle">Recommended system specifications</h5>

ElasTest needs some minimun system specifications in order to run smoothly:

<table>
  <tr>
    <td>Processor</td>
    <td>1GHz or faster</td>
  </tr>
  <tr>
    <td>RAM</td>
    <td>8GB (highly recommended 16GB)</td>
  </tr>
  <tr>
    <td>SWAP</td>
    <td>4GB (if RAM < 16GB)</td>
  </tr>
  <tr>
    <td>Hard Disk</td>
    <td>30GB</td>
  </tr>
</table>

<!-- FOR MAC -->
<h4 class="holder-subtitle link-top">For Mac</h4>

ElasTest is based on <strong>Docker</strong> technology. To execute ElasTest you need Docker CE installed on your machine following the official instructions for <a href="https://docs.docker.com/docker-for-mac/install/" target="_blank">Mac</a>.
Once you have docker installed, execute the following command to start ElasTest:

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=localhost
```

Whatever platform you are using, you will see this output when ElasTest is ready:

```text
Pulling some necessary images...

Preload images finished.

Starting ElasTest Platform (normal mode)...

ElasTest services are starting. This will likely take some time. The ElasTest URL will be shown when ready.

ElasTest Platform is available at http://localhost:37000

Press Ctrl+C to stop.
```

You can then open in your web browser the shown URL to access to ElasTest dashboard.

To stop ElasTest, press **`Ctrl+C`** in the shell used to start it. Now you can try any of the test projects available by default when you start ElasTest. You can start with [Unit Tests](your-first-test) project.

<h5 class="small-subtitle">Options</h5>

The **`--logs`** option allows you to show all the containers logs.

```
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --logs
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

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>ElasTest can be used in Mac OS, but it's recommended to use Linux. There could be unexpected bugs. If you find any issue, please report it <a href="/docs/support/">here</a>.</i></p></div>
</div>

<h5 class="small-subtitle">Recommended system specifications</h5>

ElasTest needs some minimun system specifications in order to run smoothly:

<table>
  <tr>
    <td>Processor</td>
    <td>1GHz or faster</td>
  </tr>
  <tr>
    <td>RAM</td>
    <td>16GB</td>
  </tr>
  <tr>
    <td>SWAP</td>
    <td>4GB (if RAM < 16GB)</td>
  </tr>
  <tr>
    <td>Hard Disk</td>
    <td>30GB</td>
  </tr>
</table>

<!-- FOR WINDOWS -->
<h4 class="holder-subtitle link-top">For Windows</h4>

ElasTest is based on <strong>Docker</strong> technology. To execute ElasTest you need Docker CE installed on your machine following the official instructions for <a href="https://docs.docker.com/docker-for-windows/install/" target="_blank">Docker for Windows</a> or for <a href="https://docs.docker.com/toolbox/toolbox_install_windows/" target="_blank">Docker Toolbox for Windows</a>.

Once you have docker installed, execute the following command to start ElasTest:

<div class="range range-xs-center warning-range">
  <div class="cell-xs-2 cell-lg-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-10 cell-lg-11 warning-text"><p><i>IMPORTANT: for the following command, you need to create the "~/.elastest" folder manually before.</i></p></div>
</div>

**_Docker for Windows_**

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=localhost
```

**_Docker Toolbox_** (_run it from your Docker Toolbox terminal_)
```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=$(docker-machine ip)
```

Whatever platform you are using, you will see this output when ElasTest is ready:

```text
Pulling some necessary images...

Preload images finished.

Starting ElasTest Platform (normal mode)...

ElasTest services are starting. This will likely take some time. The ElasTest URL will be shown when ready.

ElasTest Platform is available at http://localhost:37000

Press Ctrl+C to stop.
```

You can then open in your web browser the shown URL to access to ElasTest dashboard.

To stop ElasTest, press **`Ctrl+C`** in the shell used to start it. Now you can try any of the test projects available by default when you start ElasTest. You can start with [Unit Tests](your-first-test) project.



<h5 class="small-subtitle">Options</h5>

The **`--logs`** option allows you to show all the containers logs.

```
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --logs
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

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>ElasTest can be used in Windows, but it's recommended to use Linux. There could be unexpected bugs. If you find any issue, please report it <a href="/docs/support/">here</a>.</i></p></div>
</div>

<h5 class="small-subtitle">Recommended system specifications</h5>

ElasTest needs some minimun system specifications in order to run smoothly:

<table>
  <tr>
    <td>Processor</td>
    <td>1GHz or faster</td>
  </tr>
  <tr>
    <td>RAM</td>
    <td>16GB</td>
  </tr>
  <tr>
    <td>SWAP</td>
    <td>4GB (if RAM < 16GB)</td>
  </tr>
  <tr>
    <td>Hard Disk</td>
    <td>30GB</td>
  </tr>
</table>

<h4 class="holder-subtitle link-top">ElasTest on a server</h4>

To run ElasTest on a server follow the steps detailed in the <a href="/docs/deploying/ubuntu/">Linux Server </a>section.

<h4 class="holder-subtitle link-top">ElasTest on Amazon Web Services</h4>

ElasTest has been designed from the outset to offer an extremely simple deployment in Amazon Web Services. Check [Amazon Web Services](deploying/aws/) section to learn how to do it in a couple of minutes.

<h4 class="holder-subtitle link-top">Updating ElasTest</h4>

To update ElasTest to the latest _stable_ version available, just need to change **`start`** to **`update`** and **add `-it`** in the launching command:

```text
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform update
```

The `update` command will detect if you are currently running ElasTest with the same version you want to update to and, if so, warn you that if you continue that instance will be stoppped.

```text
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform update
Updating ElasTest Platform version ...
You are going to update the ElasTest version unspecified. Continue? [Y/n]
The version of ElasTest that you want to update is already running and it is  necessary to stop it. Continue? [Y/n]
```

If your answer is 'Y', then the following message will appear while ElasTest is being Updating.

```text
Preparing the environment...
```

When all containers have been pulled you will see an output similiar to:

```text
Update finished successfully.
```

In order to clean the ElasTest installation, the old images associated with the previous version will be removed from the system after the update process has finished.


<h4 class="holder-subtitle link-top">Using a specific ElasTest version</h4>

To use a specific ElasTest version available, only need to set it as elastest/platform tag, that is, adding **`:version`**. For example, to use the **`1.0.0-beta2`** version you would have to execute the following command

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform:1.0.0-beta2 start
```

<h4 class="holder-subtitle link-top">ElasTest data</h4>
You can see the Elastest data information <a href="/docs/deploying/ubuntu/#elastestData">here</a>

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
