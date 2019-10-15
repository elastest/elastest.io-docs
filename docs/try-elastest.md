<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Try ElasTest</h2>
</div>
</div>

In this section we will see how to install and start ElasTest depending on the platform you are going to use:

-   ElasTest on [Laptop](#laptop)
-   ElasTest on [Linux VM](#linuxVM)
-   ElasTest on [Server](#server)
-   ElasTest on [Kubernetes](#k8s)

We'll also see how to [manage your ElasTest installation](#etInstallationManagement).

<h3 id="laptop" class="holder-subtitle link-top link-top">ElasTest on laptop</h3>

ElasTest is based on <strong>Docker</strong> technology. To execute ElasTest you need Docker CE installed on your machine following the official instructions:

-   For <a href="https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/" target="_blank">Ubuntu</a>.
-   For <a href="https://docs.docker.com/docker-for-mac/install/" target="_blank">Mac</a>.
-   For <a href="https://docs.docker.com/docker-for-windows/install/" target="_blank">Docker for Windows</a> or for <a href="https://docs.docker.com/toolbox/toolbox_install_windows/" target="_blank">Docker Toolbox for Windows</a>.

Although ElasTest can be used on both Mac and Windows, it is **recommended to use Linux** since in these two OS docker runs on an internal VM.

<div class="offset-top-30 offset-md-top-30">
</div>

<div class="badges-menu">
    <span id="forLinux-btn" class="badge badge-default my-badge selected">For Linux</span>
    <span id="forMac-btn" class="badge badge-default my-badge my-badge-disabled">For Mac</span>
    <span id="forWindows-btn" class="badge badge-default my-badge my-badge-disabled">For Windows</span>
</div>

<!-- FOR LINUX -->
<div id="forLinux" class="badge-tutorial os-tutorial">
  <h3 class="holder-subtitle link-top link-top-index">For Linux</h3>
  <p>
    Once you have docker installed, execute the following command to start ElasTest:
  </p>
    <pre><code>docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start</code></pre>

  <p>
    Whatever platform you are using, you will see this output when ElasTest is ready:
  </p>

  <pre><code>
  Pulling some necessary images...

  Preload images finished.

  Starting ElasTest Platform latest (mini Mode)...

  Creating volume "elastest_platform-services" with local driver
  Creating elastest_platform-services_1 ... done
  Creating elastest_edm-mysql_1         ... done
  Creating elastest_etm-filebeat_1      ... done
  Creating elastest_etm_1               ... done
  Creating elastest_etm-proxy_1         ... done

  ElasTest services are starting. This will likely take some time. The ElasTest URL will be shown when ready.


  ElasTest Platform is available at http://localhost:37000

  Press Ctrl+C to stop.
  </code></pre>

  <p>You can then open in your web browser the shown URL to access to ElasTest dashboard.</p>

  <p>To stop ElasTest, press <strong class="italicEtColor">Ctrl+C</strong> in the shell used to start it. Now you can try any of the test projects available by default when you start ElasTest. You can start with <a href="/docs/your-first-test/">Unit Tests</a> project.</p>

  <h4 class="small-subtitle">Options</h4>

  <p>You can add <strong class="italicEtColor">--testlink</strong> if you want to start the TestLink integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.</p>

  <pre><code>
  docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --testlink
  </code></pre>

  <p>The <strong class="italicEtColor">--jenkins</strong> option can be added if you want to start the Jenkins integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.</p>

  <pre><code>
  docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --jenkins
  </code></pre>

  <p>You can execute <strong class="italicEtColor">--help</strong> if you need more information about the options.</p>

  <pre><code>
  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform --help
  </code></pre>

  <h4 class="small-subtitle">Recommended system specifications</h4>

  <p>ElasTest needs some minimum system specifications in order to run smoothly:</p>

  <table>
    <tr>
      <td>Processor</td>
      <td>1GHz or faster</td>
    </tr>
    <tr><!--  -->
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
</div>

<!-- FOR MAC -->
<div id="forMac" class="badge-tutorial os-tutorial">
  <h3 class="holder-subtitle link-top link-top-index">For Mac</h3>
  <p>Once you have docker installed, execute the following command to start ElasTest:</p>

  <pre><code>docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start</code></pre>

  <p>Whatever platform you are using, you will see this output when ElasTest is ready:</p>

  <pre><code>
  Pulling some necessary images...

  Preload images finished.

  Starting ElasTest Platform latest (mini Mode)...

  Creating volume "elastest_platform-services" with local driver
  Creating elastest_platform-services_1 ... done
  Creating elastest_edm-mysql_1         ... done
  Creating elastest_etm-filebeat_1      ... done
  Creating elastest_etm_1               ... done
  Creating elastest_etm-proxy_1         ... done

  ElasTest services are starting. This will likely take some time. The ElasTest URL will be shown when ready.


  ElasTest Platform is available at http://localhost:37000

  Press Ctrl+C to stop.
  </code></pre>

  <p>You can then open in your web browser the shown URL to access to ElasTest dashboard.</p>

 <p>To stop ElasTest, press <strong class="italicEtColor">Ctrl+C</strong> in the shell used to start it. Now you can try any of the test projects available by default when you start ElasTest. You can start with <a href="/docs/your-first-test/">Unit Tests</a> project.</p>

  <h4 class="small-subtitle">Options</h4>

  <p>You can add <strong class="italicEtColor">--testlink</strong> if you want to start the TestLink integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.</p>

  <pre><code>
  docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --testlink
  </code></pre>

  <p>The <strong class="italicEtColor">--jenkins</strong> option can be added if you want to start the Jenkins integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.</p>

  <pre><code>
  docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --jenkins
  </code></pre>

  <p>You can execute <strong class="italicEtColor">--help</strong> if you need more information about the options.</p>

  <pre><code>
  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform --help
  </code></pre>

  <h4 class="small-subtitle">Recommended system specifications</h4>

  <p>ElasTest needs some minimum system specifications in order to run smoothly:</p>

  <table>
    <tr>
      <td>Processor</td>
      <td>1GHz or faster</td>
    </tr>
    <tr><!--  -->
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
</div>

<div id="forWindows" class="badge-tutorial os-tutorial">
<!-- FOR WINDOWS -->
<h3 class="holder-subtitle link-top link-top-index">For Windows</h3>
  <p>Once you have docker installed, execute the following command to start ElasTest:</p>

  <div class="range range-xs-center warning-range offset-top-0">
    <div class="cell-xs-2 cell-lg-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
    <div class="cell-xs-10 cell-lg-11 warning-text"><p><i>IMPORTANT: for the following command, you need to create the "~/.elastest" folder manually before.</i></p></div>
  </div>

  <p><strong><em>Docker for Windows</em></strong></p>

  <pre><code>docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start</code></pre>

  <p><strong><em>Docker Toolbox</em></strong>(_run it from your Docker Toolbox terminal_)</p>

  <pre><code>
  docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --server-address=$(docker-machine ip)
  </code></pre>

  <p>Whatever platform you are using, you will see this output when ElasTest is ready:</p>

  <pre><code>
  Pulling some necessary images...

  Preload images finished.

  Starting ElasTest Platform latest (mini Mode)...

  Creating volume "elastest_platform-services" with local driver
  Creating elastest_platform-services_1 ... done
  Creating elastest_edm-mysql_1         ... done
  Creating elastest_etm-filebeat_1      ... done
  Creating elastest_etm_1               ... done
  Creating elastest_etm-proxy_1         ... done

  ElasTest services are starting. This will likely take some time. The ElasTest URL will be shown when ready.


  ElasTest Platform is available at http://localhost:37000

  Press Ctrl+C to stop.
  </code></pre>

  <p>You can then open in your web browser the shown URL to access to ElasTest dashboard.</p>

  <p>To stop ElasTest, press <strong class="italicEtColor">Ctrl+C</strong> in the shell used to start it. Now you can try any of the test projects available by default when you start ElasTest. You can start with <a href="/docs/your-first-test/">Unit Tests</a> project.</p>

  <h4 class="small-subtitle">Options</h4>

  <p>You can add <strong class="italicEtColor">--testlink</strong> if you want to start the TestLink integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.</p>

  <pre><code>
  docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --testlink
  </code></pre>

  <p>The <strong class="italicEtColor">--jenkins</strong> option can be added if you want to start the Jenkins integrated in ElasTest and enable access to it. If you do not add this option, you can start it later manually from the ElasTest GUI.</p>

  <pre><code>
  docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start --jenkins
  </code></pre>

  <p>You can execute <strong class="italicEtColor">--help</strong> if you need more information about the options.</p>

  <pre><code>
  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock elastest/platform --help
  </code></pre>

  <h4 class="small-subtitle">Recommended system specifications</h4>

  <p>ElasTest needs some minimum system specifications in order to run smoothly:</p>

  <table>
    <tr>
      <td>Processor</td>
      <td>1GHz or faster</td>
    </tr>
    <tr><!--  -->
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
</div>

<h3 id="linuxVM" class="holder-subtitle link-top">ElasTest on a Linux Virtual Machine</h3>

To run ElasTest on a Linux Virtual Machine and be able to access it from the host it is necessary to use the **`--server-address`** option with the IP of the VM that the host sees as value. Once you have started ElasTest you should be able to access the url **`http://VM-IP:37000`** from your browser on the host.

<h3 id="server" class="holder-subtitle link-top">ElasTest on a server</h3>

<h4 class="small-subtitle">Linux server</h4>

To run ElasTest on a Linux server follow the steps detailed in the <a href="/docs/deploying/ubuntu/">Linux Server </a>section.

<h4 class="small-subtitle">Amazon Web Services</h4>

ElasTest has been designed from the outset to offer an extremely simple deployment in Amazon Web Services. Check [Amazon Web Services](deploying/aws/) section to learn how to do it in a couple of minutes.


<h3 id="k8s" class="holder-subtitle link-top">ElasTest on Kubernetes</h3>

You have all the information <a href="/docs/deploying/kubernetes">here</a>.

<h3 id="etInstallationManagement" class="holder-subtitle link-top">ElasTest Installation Management</h3>

<h4 class="small-subtitle">Updating ElasTest</h4>

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

<h4 class="small-subtitle">Using a specific ElasTest version</h4>

To use a specific ElasTest version available, only need to set it as elastest/platform tag, that is, adding **`:version`**. For example, to use the **`1.0.0`** version you would have to execute the following command

```text
docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform:1.0.0 start
```

<h4 class="small-subtitle">ElasTest data</h4>
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

<script>
$('#forLinux-btn').click(function(event) {
  activateBadge('forLinux');
});
$('#forMac-btn').click(function(event) {
  activateBadge('forMac');
});
$('#forWindows-btn').click(function(event) {
  activateBadge('forWindows');
});


function activateBadge(sectionName) {
  var disabledClass = 'my-badge-disabled';
  var selectedClass = 'selected';
  
  $('.os-tutorial').hide();
  $('#' + sectionName).show();
  
  // Disable current selected
  $('.selected').addClass(disabledClass);
  $('.selected').removeClass(selectedClass);
  
  // Select clicked
  $('#' + sectionName + '-btn').addClass(selectedClass);
  $('#' + sectionName + '-btn').removeClass(disabledClass);
}

window.onload = function() {
      activateBadge('forLinux');

      var specificHash = window.location.hash;
      if(specificHash != null){
        if(specificHash == "#forWindows"){
          activateBadge('forWindows');
          console.log(window.scrollY)
          window.scrollTo(window.scrollX, 15);
        } else if(specificHash == "#forMac"){
          activateBadge('forMac');
        }
      }
}
</script>
