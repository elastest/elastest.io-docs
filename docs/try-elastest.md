<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Try Elastest</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<p>ElasTest can be quickly installed in your own development machine.</p>
<p>ElasTest is based on <strong>Docker</strong> technology. To execute ElasTest you need Docker CE installed on your machine following the official instructions for <a href="https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/" target="_blank">Ubuntu</a>, <a href="https://docs.docker.com/docker-for-mac/install/" target="_blank">Mac</a> or <a href="https://docs.docker.com/docker-for-windows/install/" target="_blank">Windows</a>.
</p>

For **Ubuntu**, **Mac** and **Windows** (*Docker for Windows*):

```text
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start
```

For **Windows** (*Docker Toolbox*):

```text
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=$(docker-machine ip)
```

You will see this output when ElasTest is ready:

```text
Starting ElasTest Platform (Lite Mode)...

Please wait a few seconds while we start the ElasTest services, the ElasTest URL will be shown when ready.

ElasTest Platform is available at http://YOUR_MACHINE_IP:37000
```

You can then open in your web browser the shown URL to access to ElasTest dashboard.

To stop ElasTest, press `Ctrl+C` in the shell used to start it. You can now try the [Hello world](/getting-started/hello-world) project available by default when launching ElasTest.


<h2 class="h3 no-border">Recommended system specifications</h2>

ElasTest needs some minimun system specifications in order to run smoothly:

<table>
  <tr>
    <td>Processor</td>
    <td>1GHz or faster</td>
  </tr>
  <tr>
    <td>RAM</td>
    <td>8GB (strongly recommended 16GB)</td>
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

<!--Note: In Linux OS you can use the command `free -m` to know if your machine has SWAP memory enabled.-->


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
