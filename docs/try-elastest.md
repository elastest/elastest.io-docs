<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Try Elastest</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<p>ElasTest is based on <strong>Docker</strong> technology. To execute ElasTest you need Docker CE installed on your machine following the official instructions for <a href="https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/" target="_blank">Ubuntu</a>, <a href="https://docs.docker.com/docker-for-mac/install/" target="_blank">Mac</a> or <a href="https://docs.docker.com/docker-for-windows/install/" target="_blank">Windows</a>.
</p>

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>ElasTest is intended to be deployed on a dedicated server due to the considerable amount of modules and technologies that are part of it. If you really want ElasTest to show its true potential, it is strongly recommended to launch it in a powerful environment (see <a href="#system-specs">Recommended system specifications</a>). To deploy ElasTest in a dedicated server or in Amazon Web Services, please check section <a href="/docs/deploying/aws">Deploying ElasTest</a>.</i></p></div>
</div>

<h4 class="holder-subtitle link-top">For Linux</h4>

```text
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start
```
Whatever platform you are using, you will see this output when ElasTest is ready:

```text
Starting ElasTest Platform (normal mode)...

Please wait a few seconds while we start the ElasTest services, the ElasTest URL will be shown when ready.

ElasTest Platform is available at http://localhost:37000
```

You can then open in your web browser the shown URL to access to ElasTest dashboard.

To stop ElasTest, press `Ctrl+C` in the shell used to start it. You can now try the [Hello world](your-first-test) project available by default when launching ElasTest.

<h4 class="holder-subtitle link-top">For Mac</h4>

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>ElasTest has not been fully tested on Mac OS. There could be unexpected bugs. If you find any issue, please report it <a href="/docs/support/">here</a>.</i></p></div>
</div>
<br>

```text
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start
```
<h4 class="holder-subtitle link-top">For Windows</h4>

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>ElasTest has not been fully tested on Windows. There could be unexpected bugs. If you find any issue, please report it <a href="/docs/support/">here</a>.</i></p></div>
</div>

***Docker for Windows***

```text
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=localhost
```

***Docker Toolbox*** (_run it from your Docker Toolbox terminal_)

```text
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=$(docker-machine ip)
```

<h4 class="holder-subtitle link-top">ElasTest on Amazon Web Services</h4>

ElasTest has been designed from the outset to offer an extremely simple deployment in Amazon Web Services. Check [Amazon Web Services](deploying/aws/) section to learn how to do it in a couple of minutes.

<h4 class="holder-subtitle link-top">Updating ElasTest</h4>

To update ElasTest to the latest version available, just need to change `start` to `update` in the launching command. For example:

```text
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform update
```

When all containers have been pulled you will see an output similiar to:

```text
Update finished successfully.
```
<div style="margin-top: 30px">
<h4 id="next-update" class="link-top">In following versions</h4>
</div>

The `update` command will being improved and in the next vervion `0.6.0-beta4`, it will provide the following new functionality.

The `update` command will detect if you are running an ElasTest with the same version that you want to update and, if so, warn you that if you continue that instance it will stop.

```text
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform update
Updating ElasTest Platform version ...
You are going to update the ElasTest version unspecified. Continue? [Y/n]
The version of ElasTest that you want to update is already running and it is  necessary to stop it. Continue? [Y/n]
```

If your answer is 'Y', then the following message will appear while ElasTest stops.

```text
Preparing the environment...
Stopping ElasTest..............
```

To clean the ElasTest installation, when the updating have finished, the old images associated with the current version of ElasTest installed on your PC will be removed from the system.

<h4 class="holder-subtitle link-top" id="system-specs">Recommended system specifications</h4>

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

<br>

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
