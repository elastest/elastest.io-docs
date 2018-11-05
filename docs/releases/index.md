<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Releases</h2>
</div>
</div>

<div id="1.0.0-beta3">
<h3 class="small-subtitle">1.0.0-beta3</h3>
<h4 class="smaller-subtitle">31/10/2018</h4>

<ul>
<h5 class="smaller-subtitle">Features & Improvements</h5>
<li><a target="_blank" href="/docs/testing/multi-configuration-tjobs">Multi-configuration TJobs.</a> Execute same TJob with different configurations, compare several executions and improve visualization with matrices and graphs (Basic Orchestration).</li>
<li><a target="_blank" href="/docs/testing/sut/#outsideExternalES">New type of Sut:</a> Use External Elasticsearch.</li>
<li><a target="_blank" href="/docs/web-browsers/manual-browsers">Now the init/pull progress of the browsers is shown in the modal window.</a></li>
<li><a target="_blank" href="javascript:void(0);">ElasTest Internal Error messages are now displayed</a> on the results page of a TJob Execution.</li>
<li><a target="_blank" href="javascript:void(0);">Ability to duplicate TJobs and Suts</a> on the specific project page.</li>

<h5 class="smaller-subtitle">Bug Fixes</h5>
<li><a target="_blank" href="javascript:void(0);">Now the list of executions is reloaded when deleting a project in the Dashboard section.</a></li>
<li><a target="_blank" href="/docs/testlink">Automatic sync when TestLink is started manually and be ready</a> to show projects directly instead of needing to re-navigate</li>

</ul>
</div>

<div id="1.0.0-beta2">
<h3 class="small-subtitle">1.0.0-beta2</h3>
<h4 class="smaller-subtitle">04/10/2018</h4>

<ul>
<h5 class="smaller-subtitle">Improvements</h5>
<li><a target="_blank" href="/docs/deploying/ubuntu/#elastestData">Now you can configure the ElasTest data folder at startup.</a> If the folder is changed in future startups, the contents of the config folder must be copied if TL was reached at any time.</li>
<li><a target="_blank" href="javascript:void(0);">TestLink and Jenkins credentials.</a> The credentials will be the same credentials as those introduced for ElasTest. If it has not been entered, they will be created.</li>
<li><a target="_blank" href="/docs/web-browsers/manual-browsers/">Manually started browsers can now be opened in a new tab.</a></li>
<li><a target="_blank" href="javascript:void(0);">Now it shows where the logs and metrics of a TJobExec are stored</a> (MYSQL if it is mini or ELASTICSEARCH if it is experimental)</li>
<li><a target="_blank" href="javascript:void(0);">Now the volumes created by the execution of a TJob are removed at the end of this.</a></li>
<li><a target="_blank" href="javascript:void(0);">Error message on start ElasTest if main container (ETM) is exited.</a> An error file is also generated in case the user wants to send it to the ElasTest team.</li>
<li><a target="_blank" href="javascript:void(0);">The time conversion of the monitoring traces is now more efficient.</a> It is calculated once per host name and only transforms if necessary.</li>
<li><a target="_blank" href="javascript:void(0);">Now the connections to the WebSockets are reconnected automatically if the connection is lost.</a></li>

<h5 class="smaller-subtitle">Bug Fixes</h5>
<li><a target="_blank" href="javascript:void(0);">Automatic navigation to the results page when the execution of the test finishes.</a></li>
<li><a target="_blank" href="javascript:void(0);">Problem with duplicate logs fixed.</a></li>
<li><a target="_blank" href="/docs/jenkins/advanced-example/">Automatic subscription to the Sut logs of a Jenkins execution.</a></li>
<li><a target="_blank" href="javascript:void(0);">The problem with the generation of the Jenkins url when starting from the platform in experimental mode and as a server has been solved.</a> </li>
<li><a target="_blank" href="javascript:void(0);">Bug with the Nginx proxy image fixed. </a> It did not receive the SIGTERM signal and ElasTest Platform took a long time to stop (until it gave a waiting time of 90 and stopped the proxy to force)</li>
<li><a target="_blank" href="javascript:void(0);">Startup problems in Windows and MacOS has been solved.</a> Now the volumes `/etc/localtime` and `/etc/timezone` are no longer binded to the `elastest/etm` container; instead ElasTest Platform is that requests it via HTTP and sends it as a parameter to the ETM.</li>
<li><a target="_blank" href="javascript:void(0);">Both Jenkins and the ElasTest plugin are now correctly configured when Jenkins starts from the Platform.</a></li>
<li><a target="_blank" href="javascript:void(0);">Problem with splitted log traces and without date has been fixed.</a></li>

</ul>
</div>

<div id="1.0.0-beta1">
<h3 class="small-subtitle">1.0.0-beta1</h3>
<h4 class="smaller-subtitle">12/09/2018</h4>

<ul>
<li><a target="_blank" href="/docs/try-elastest/">Improvement in requirements.</a> We've been working on the high memory consumption requirements of previous versions, and this new version can be deployed on machines with 8Gb of RAM starting ElasTest in default mode</li>

<li><a href="">GUI improvements.</a> Among other small improvements, it should be noted that more information is now shown to the user, such as the percentage of downloading a docker image, either from a tjob, a sut or a browser.</li>

<li><a target="_blank" href="/docs/jenkins/">Improvements in Jenkins plugin.</a> It is no longer necessary for the user to start dockbeat and filebeat to send logs and metrics to ElasTest, the plugin is responsible for it now.</li>

<li><a target="_blank" href="/docs/jenkins/">Jenkins instance provided by ElasTest.</a> You can use now a Jenkins instance provided by ElasTest, can be started on load ElasTest or later manually from the ElasTest GUI.</li>

<li><a target="_blank" href="/docs/testlink/">Improvements in TestLink integration.</a> It is possible to configure a Sut so that ElasTest starts it every time a Test Plan is executed</li>

<li><a target="_blank" href="/docs/log-analyzer/">Improvements in log analysis.</a></li>

<li><a href="javascript:void(0);">Bug fixes.</a></li>
</ul>
</div>

<div id="0.9.1">
<h3 class="small-subtitle">0.9.1</h3>
<h4 class="smaller-subtitle">09/05/2018</h4>

<ul>
<li><a target="_blank" href="/docs/jenkins/">Jenkins integration.</a> You don’t need to abandon your CI tools. Use ElasTest straight from your Jenkins jobs (Freestyle or Pipeline). For instance, if you’re using Pipeline jobs, just wrap up your Pipeline in an elastest step, and you’ll be ready to use all the fancy features we bring to testers and developers, like managed browsers! See our advanced example for a more complex scenario.</li>

<li><a target="_blank" href="/docs/testlink/">TestLink integration.</a> TestLink is the most widely used web-based test management tool and ElasTest provides integration with TestLink. With this integration now you can easily record videos and gather logs and metrics when manually running your tests.</li>

<li><a target="_blank" href="https://hub.docker.com/u/elastestbrowsers/">New Docker images for browsers.</a> We have been developing a new set of browser Docker images that brings the benefits of both Selenoid and Selenium docker images. These images are ready for some awesome features we will be developing in the following months, like changing browser resolution to adapt better to the desktop of our users.</li>

<li><a target="_blank" href="/docs/web-browsers/manual-browsers/">Browser recordings</a> can now be opened as a new tab or on a floating dialog.</li>

<li><a target="_blank" href="/docs/log-analyzer/">Our powerful Log Analyzer</a> now remembers previous configurations.</li>

<li><a target="_blank" href="/docs/testing/sut/">Generate your SuT on the fly with Commands Containers</a>: a new Docker image can be generated on the fly, and this image will be run as the SuT.</li>

<li><a target="_blank" href="/docs/docs/try-elastest/">ElasTest Command line options documented</a> in its own subsection within the installation page.</li>

<li><a target="_blank" href="/docs/testing/environment-variables/">Changes in environment variables: the ElasTest endpoint</a> for sending metrics from an external SuT has changed, and the ET_MON_LSHTTP_API environment variable is now available also for Test Support Services.</li>

<li><a target="_blank" href="/docs/testing/environment-variables/">There are new environment variables available</a>: ET_SUT_CONTAINER_NAME, ET_MON_INTERNAL_LSBEATS_PORT and ET_SUT_LOG_TAG. Those allows ElasTest to do a better job when identifying what’s coming from which SuT.</li>

<li>We have changed the name of the status for a TJob that has been stopped manually to STOPPED.</li>
</ul>
</div>
