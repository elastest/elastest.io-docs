<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Releases</h2>
</div>
</div>

<div id="0.9.1">
<h3>0.9.1</h3>
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