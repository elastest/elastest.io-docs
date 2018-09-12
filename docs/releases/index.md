<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Releases</h2>
</div>
</div>

<div id="1.0.0-beta1">
<h3>1.0.0-beta1</h3>
<div>12/09/2018</div>

<ul>
<li><a target="_blank" href="/docs/try-elastest/#system-specs">Improvement in requirements.</a> We've been working on the high memory consumption requirements of previous versions, and this new version can be deployed on machines with 8Gb of RAM starting ElasTest in default mode</li>

<li><a href="">GUI improvements.</a> Among other small improvements, it should be noted that more information is now shown to the user, such as the percentage of downloading a docker image, either from a tjob, a sut or a browser.</li>

<li><a target="_blank" href="/docs/jenkins/">Improvements in Jenkins plugin.</a> It is no longer necessary for the user to start dockbeat and filebeat to send logs and metrics to ElasTest, the plugin is responsible for it now.</li>

<li><a target="_blank" href="/docs/jenkins/">Jenkins instance provided by ElasTest.</a> You can use now a Jenkins instance provided by ElasTest, can be started on load ElasTest or later manually from the ElasTest GUI.</li>

<li><a target="_blank" href="/docs/testlink/">Improvements in TestLink integration.</a> It is possible to configure a Sut so that ElasTest starts it every time a Test Plan is executed</li>

<li><a target="_blank" href="/docs/log-analyzer/">Improvements in log analysis.</a></li>

<li><a href="#">Bug fixes.</a></li>
</ul>
</div>

<div id="0.9.1">
<h3>0.9.1</h3>
<div>09/05/2018</div>

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
