<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Releases</h2>
</div>
</div>

<!-- ************************* -->
<!-- ****** 1.0.0-beta4 ****** -->
<!-- ************************* -->

<h3 id="1.0.0-beta4" class="small-subtitle">1.0.0-beta4</h3>
<h4 class="smaller-subtitle">end/11/2018</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

-   It is no longer necessary to specify the  **`--server-address=localhost`** when running on <a target="_blank" href="/docs/try-elastest/#forMac">MAC</a> or <a target="_blank" href="/docs/try-elastest/#forWindows">Windows</a> (In docker for Windows, in Docker toolbox **`--server-address=$(docker-machine ip)`** is still necessary).
-   All active live sessions are now shown in <a target="_blank" href="/docs/web-browsers/manual-browsers">Web Browsers section</a>.
-   A <strong class="italicEtColor">button to restore the demo projects</strong> has been added on the project card.
-   <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a> has been updated to <strong class="italicEtColor">Java 8</strong>.
-   A system of retries has been added to send the traces to ElasTest in the <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a>.
-   **Logstash** has been updated to 6.5.0 version (Logstash is only available in Elastest <a target="_blank" href="/docs/experimental">experimental mode</a>)

<h5 class="smaller-subtitle">Bug Fixes</h5>
-   Now the <a target="_blank" href="/docs/testing/environment-variables/">environment variables</a> ET_SUT_PORT and ET_SUT_PROTOCOL are passed to the test container.
-   The error on open Monitoring Config modal during the <a target="_blank" href="/docs/testlink/">TestLink</a> Test Plan execution has been solved.
-   In <a target="_blank" href="/docs/log-analyzer/">LogAnalyzer</a>, when "Reload Log" button is clicked the multiline log is maintained (if activated).
-   If you open the <a target="_blank" href="/docs/web-browsers/manual-browsers">Web Browsers page</a> during the execution of a <a target="_blank" href="/docs/web-browsers/e2e-browser">TJob that uses a browser</a>, they no longer appear.
-   Fixed problem when <strong class="italicEtColor">sending traces with characters without escaping</strong> in <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a>.

<!-- ************************* -->
<!-- ****** 1.0.0-beta3 ****** -->
<!-- ************************* -->

<h3  id="1.0.0-beta3" class="small-subtitle">1.0.0-beta3</h3>
<h4 class="smaller-subtitle">31/10/2018</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>
-   <a target="_blank" href="/docs/testing/multi-configuration-tjobs">Multi-configuration TJobs.</a> Execute same TJob with different configurations, compare several executions and improve visualization with matrices and graphs (Basic Orchestration).
-   <a target="_blank" href="/docs/testing/sut/#outsideExternalES">New type of Sut:</a> Use External Elasticsearch.
-   <a target="_blank" href="/docs/web-browsers/manual-browsers">Now the init/pull progress of the browsers is shown in the modal window</a>.
-   <strong class="italicEtColor">ElasTest Internal Error messages are now displayed</strong> on the results page of a TJob Execution.
-   <strong class="italicEtColor">Ability to duplicate TJobs and Suts</strong> on the specific project page.

<h5 class="smaller-subtitle">Bug Fixes</h5>
-   Now the <strong class="italicEtColor">list of executions is reloaded when deleting a project</strong> in the Dashboard section.
-   <a target="_blank" href="/docs/testlink">Automatic sync when TestLink is started manually and be ready</a> to show projects directly instead of needing to re-navigate

<!-- ************************* -->
<!-- ****** 1.0.0-beta2 ****** -->
<!-- ************************* -->

<h3 id="1.0.0-beta2" class="small-subtitle">1.0.0-beta2</h3>
<h4 class="smaller-subtitle">04/10/2018</h4>

<h5 class="smaller-subtitle">Improvements</h5>
-   <a target="_blank" href="/docs/deploying/ubuntu/#elastestData">Now you can configure the ElasTest data folder at startup.</a> If the folder is changed in future startups, the contents of the config folder must be copied if TL was reached at any time.
-   <strong class="italicEtColor">TestLink and Jenkins credentials.</strong> The credentials will be the same credentials as those introduced for ElasTest. If it has not been entered, they will be created.
-   <a target="_blank" href="/docs/web-browsers/manual-browsers/">Manually started browsers can now be opened in a new tab</a>.
-   <strong class="italicEtColor">Now it shows where the logs and metrics of a TJobExec are stored</strong> (MYSQL if it is mini or ELASTICSEARCH if it is experimental)
-   <strong class="italicEtColor">Now the volumes created by the execution of a TJob are removed at the end of this</strong>.
-   <strong class="italicEtColor">Error message on start ElasTest if main container (ETM) is exited.</strong> An error file is also generated in case the user wants to send it to the ElasTest team.
-   <strong class="italicEtColor">The time conversion of the monitoring traces is now more efficient.</strong> It is calculated once per host name and only transforms if necessary.
-   Now the connections to the <strong class="italicEtColor">WebSockets are reconnected automatically if the connection is lost</strong>.

<h5 class="smaller-subtitle">Bug Fixes</h5>
-   <strong class="italicEtColor">Automatic navigation to the results page</strong> when the execution of the test finishes.
-   <strong class="italicEtColor">Problem with duplicate logs fixed</strong>.
-   <a target="_blank" href="/docs/jenkins/advanced-example/">Automatic subscription to the Sut logs of a Jenkins execution</a>.
-   <strong class="italicEtColor">The problem with the generation of the Jenkins url when starting from the platform in experimental mode and as a server has been solved.</strong> 
-   <strong class="italicEtColor">Bug with the Nginx proxy image fixed. </strong> It did not receive the SIGTERM signal and ElasTest Platform took a long time to stop (until it gave a waiting time of 90 and stopped the proxy to force)
-   <strong class="italicEtColor">Startup problems in Windows and MacOS has been solved.</strong> Now the volumes `/etc/localtime` and `/etc/timezone` are no longer binded to the `elastest/etm` container; instead ElasTest Platform is that requests it via HTTP and sends it as a parameter to the ETM.
-   <strong class="italicEtColor">Both Jenkins and the ElasTest plugin are now correctly configured</strong> when Jenkins starts from the Platform.
-   Problem with <strong class="italicEtColor">splitted log traces and without date</strong> has been fixed.

<!-- ************************* -->
<!-- ****** 1.0.0-beta1 ****** -->
<!-- ************************* -->

<h3 id="1.0.0-beta1" class="small-subtitle">1.0.0-beta1</h3>
<h4 class="smaller-subtitle">12/09/2018</h4>

-   <a target="_blank" href="/docs/try-elastest/">Improvement in requirements.</a> We've been working on the high memory consumption requirements of previous versions, and this new version can be deployed on machines with 8Gb of RAM starting ElasTest in default mode

-   <a href="">GUI improvements.</a> Among other small improvements, it should be noted that more information is now shown to the user, such as the percentage of downloading a docker image, either from a tjob, a sut or a browser.

-   <a target="_blank" href="/docs/jenkins/">Improvements in Jenkins plugin.</a> It is no longer necessary for the user to start dockbeat and filebeat to send logs and metrics to ElasTest, the plugin is responsible for it now.

-   <a target="_blank" href="/docs/jenkins/">Jenkins instance provided by ElasTest.</a> You can use now a Jenkins instance provided by ElasTest, can be started on load ElasTest or later manually from the ElasTest GUI.

-   <a target="_blank" href="/docs/testlink/">Improvements in TestLink integration.</a> It is possible to configure a Sut so that ElasTest starts it every time a Test Plan is executed

-   <a target="_blank" href="/docs/log-analyzer/">Improvements in log analysis</a>.

-   <a href="javascript:void(0);">Bug fixes</a>.

<!-- ************************* -->
<!-- ********* 0.9.1 ********* -->
<!-- ************************* -->

<h3 id="0.9.1" class="small-subtitle">0.9.1</h3>
<h4 class="smaller-subtitle">09/05/2018</h4>

-   <a target="_blank" href="/docs/jenkins/">Jenkins integration.</a> You don’t need to abandon your CI tools. Use ElasTest straight from your Jenkins jobs (Freestyle or Pipeline). For instance, if you’re using Pipeline jobs, just wrap up your Pipeline in an elastest step, and you’ll be ready to use all the fancy features we bring to testers and developers, like managed browsers! See our advanced example for a more complex scenario.

-   <a target="_blank" href="/docs/testlink/">TestLink integration.</a> TestLink is the most widely used web-based test management tool and ElasTest provides integration with TestLink. With this integration now you can easily record videos and gather logs and metrics when manually running your tests.

-   <a target="_blank" href="https://hub.docker.com/u/elastestbrowsers/">New Docker images for browsers.</a> We have been developing a new set of browser Docker images that brings the benefits of both Selenoid and Selenium docker images. These images are ready for some awesome features we will be developing in the following months, like changing browser resolution to adapt better to the desktop of our users.

-   <a target="_blank" href="/docs/web-browsers/manual-browsers/">Browser recordings</a> can now be opened as a new tab or on a floating dialog.

-   <a target="_blank" href="/docs/log-analyzer/">Our powerful Log Analyzer</a> now remembers previous configurations.

-   <a target="_blank" href="/docs/testing/sut/">Generate your SuT on the fly with Commands Containers</a>: a new Docker image can be generated on the fly, and this image will be run as the SuT.

-   <a target="_blank" href="/docs/docs/try-elastest/">ElasTest Command line options documented</a> in its own subsection within the installation page.

-   <a target="_blank" href="/docs/testing/environment-variables/">Changes in environment variables: the ElasTest endpoint</a> for sending metrics from an external SuT has changed, and the ET_MON_LSHTTP_API environment variable is now available also for Test Support Services.

-   <a target="_blank" href="/docs/testing/environment-variables/">There are new environment variables available</a>: ET_SUT_CONTAINER_NAME, ET_MON_INTERNAL_LSBEATS_PORT and ET_SUT_LOG_TAG. Those allows ElasTest to do a better job when identifying what’s coming from which SuT.

-   We have changed the name of the status for a TJob that has been stopped manually to STOPPED.
