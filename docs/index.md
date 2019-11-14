<div class="range range-xs-center">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">What is ElasTest?</h2>
<div class="offset-top-30 offset-md-top-30">
<p>ElasTest is a platform aimed to ease end to end testing of distributed systems. The two key features of the platform are: 1) Provide an easy deployment process and easy access to the necessary services usually involved in an end to end test and 2) Provide easy-to-use tools to show and analyze logs and metrics of all elements involved in an end to end test.</p><p>For example, suppose a typical three tier web application with a database. A basic e2e test has the following components: the test itself, web browser, web application and database. All those elements have to be properly deployed, linked and executed, and all of them can generate logs and metrics of several types (CPU, memory, network packets…). A test being executed in ElasTest can make direct use of multiple integrated services (such as Web Browsers), and the tester can see all that monitoring information in the same graphical user interface and with advanced analysis features.
</p>

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-2" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-10 warning-text"><p><i>ElasTest is currently in active development. This means that new features are constantly being added and unexpected bugs may appear</i></p></div>
</div>

</div>
</div>
<div class="cell-xs-10 cell-lg-6 cell-lg-push-2">
<img src="./images/logo-title-dark.png" width="960" height="540" class="img-responsive reveal-inline-block offset-top-10" style="border: none; margin-bottom: 0"/>
<p style="text-align: center; margin-top: 0; font-size: 18px; font-weight: 100">An elastic platform to ease end to end testing</p>
</div>
</div>

<h3 class="holder-subtitle link-top">ElasTest main features</h3>

<div class="range range-xs-center" style="margin-top: 0; text-align: center">
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon-xlg icon-circle icon-carrot-filled fas fa-sitemap icon-primary"></span>
        <h4 class="h4 text-bold">Test management</h4>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>Build your testing environment with the tools offered by ElasTest</strong><hr class="doc-features">Easily connect all the components wherever they are and run your tests in a few clicks</p>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon-xlg icon-circle icon-carrot-filled fas fa-chart-line icon-primary"></span>
        <h4 class="h4 text-bold">Metrics monitoring</h4>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>Get useful information from all your components</strong><hr class="doc-features">Every test, web browser, database, application... generates logs and consumes computing resources. And knowing when and how they change can give you a huge advantage as a tester</p>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon-xlg icon-circle icon-carrot-filled fab fa-chrome icon-primary"></span>
        <h4 class="h4 text-bold">Web browsers</h4>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>Any browser. Of any version</strong><hr class="doc-features">As testers we know how hard it is to ensure that our applications work properly in all browsers and versions. ElasTest makes this an easy task</p>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon-xlg icon-circle icon-carrot-filled fas fa-sort-amount-down icon-primary"></span>
        <h4 class="h4 text-bold">Log analyzer</h4>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>A powerful tool for finding what you want in the vast flood of logs</strong><hr class="doc-features">Gathering logs is only the first step. None of this would make sense if you couldn't dive into your logs with a powerful, intuitive and adaptative tool as ElasTest Log Analyzer</p>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon-xlg icon-circle icon-carrot-filled fab fa-jenkins icon-primary"></span>
        <h4 class="h4 text-bold">Jenkins integration</h4>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>ElasTest and Jenkins work together with a marvelous integration</strong><hr class="doc-features">ElasTest provides a Jenkins plugin for you to use the platform in your CI environment. Thanks to this you can make use of some features provided by ElasTest, such as log analysis or the use of on-demand browsers.</p>
    </div>
</div>

<h3 class="holder-subtitle link-top" id="elastest-core-concepts">ElasTest core concepts</h3>

<p>
ElasTest is built around 3 main elements:

<div style="margin-top: 30px">
    <h4 id="sut" class="link-top">Software under Test (SuT)</h4>
    The tested software itself. ElasTest supports two deployment modes of SuT:
    <ul>
        <li><i>SuT deployed by ElasTest</i>: your software is packaged as Docker container/s. It can be a single Docker image or a docker-compose.</li>
        <li><i>SuT outside ElasTest</i>: your software is already deployed somewhere.</li>
    </ul>
</div>

<div style="margin-top: 30px">
    <h4 id="tjob" class="link-top">Test Job (TJob)</h4>
    Test to be executed against your SuT. In a TJob several things have to be specified:
    <ul>
        <li><i>Environment to execute the tests</i>: This is defined with a docker image that contains all tools used by the tests.</li>
        <li><i>How to retrieve and execute the tests</i>: Specified as a set of commands written in bash that will be executed inside the docker container defined as environment.</li>
        <li><i>The SuT against which the tests are executed</i>: That is, the SuT description. If the SuT is deployed by ElasTest, it only needs the Docker image or docker-compose. If the Sut is outside ElasTest, it is necessary to specify how to reach it (usually with its IP).</li></br>
    </ul>
    A TJob can be executed several times. That can be useful, for example, because SuT has changes and we want to verify that old features are still working. Or if we add more tests to the same TJob test repo, we can execute them against the SuT.
</div>

<div style="margin-top: 30px">
   <h4 id="tss" class="link-top">Services</h4>
   Services offered by ElasTest to ease the execution and analysis of TJobs. At the moment, ElasTest only provides <strong>Web Browser Service</strong> and <strong>Log Analyzer Service</strong>, but in the near future ElasTest will offer other services as <strong>mobile devices emulators</strong>, <strong>IoT devices</strong>, <strong>security services</strong> and <strong>Big Data services</strong>.
</div>

<!--<blockquote>
These three elements are the core concepts of ElasTest platform and they are also the <strong>components targeted</strong> by ElasTest platform.
<br>
In other words: <strong>SuT's, TJob's and TSS's are the modules that ElasTest can monitor and analyse for you</strong>. You can gather information and check logs and metrics for any SuT, TJob or TSS. To learn more check <a href="/docs/monitoring">Monitoring</a> section.
</blockquote>-->

</p>

<h3 class="holder-subtitle link-top">ElasTest technologies</h3>

<img src="./images/elastest-tech.png" alt="ElasTest technologies" class="img-responsive reveal-inline-block offset-top-10" style="border: none">

<h3 id="modes" class="holder-subtitle link-top">ElasTest modes</h3>

ElasTest has different execution modes:

##### Over Docker

-   **Mini** (mini): This mode is intended for testing on a **`laptop`** or **`small server`**.
-   **Single-Node** (singlenode): This mode is intended for testing on **`servers`** with with better technical characteristics. The main differences with **`mini`** are:
    -   Logs and metrics are stored in ElasticSearch and processed with Logstash, while in mini they are saved in MySQL.
    -   Modular architecture based on containers (ESM)
    -   The ElasTest Platform Monitoring service is available

##### Over Kubernetes

-   **EK** (ElasTest over Kubernetes): For **`elastic`** environments. Similar to ElasTest mini (Docker)
-   **HEK** (Highly Scalable ElasTest Kubernetes soon): ElasTest with high availability over Kubernetes. Similar to ElasTest single-node (Docker)

In the ([Try ElasTest](/try-elastest/)) section you can find out more about how to start a specific mode and what its technical features are.

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