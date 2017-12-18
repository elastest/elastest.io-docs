<div class="range range-xs-center">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">What is ElasTest?</h2>
<div class="offset-top-30 offset-md-top-50">
<p><i>ElasTest : a platform made by testers for testers</i></p>
<p>ElasTest is a platform aimed to ease end to end testing of distributed systems. One of the key features of the platform is the ability to show and analyze logs and metrics of all elements involved in an end to end test.</p><p>For example, suppose a typical three tier web application with a database. A basic e2e test has the following components: the test itself, web browser, web application and database. All those elements can generate logs and metrics of several types (CPU, memory, network packets…). When a test is executed using ElasTest, the tester can see all that monitoring information in the same graphical user interface and with advanced analysis features. 
</p>
<blockquote><strong>WARNING</strong>: ElasTest is currently in active development. This means that new features are constantly being added and unexpected bugs may appear.</blockquote>
</div>
</div>
<div class="cell-xs-10 cell-lg-6 cell-lg-push-2"><img src="./images/logo-title-dark.png" width="960" height="540" class="img-responsive reveal-inline-block offset-top-10" style="border: none"></div>
</div>

<h4 class="holder-subtitle link-top">ElasTest main features</h4>

<div class="range range-xs-center" style="margin-top: 0; text-align: center">
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon icon-xlg icon-circle icon-carrot-filled fa fa-sitemap icon-primary"></span>
        <h3 class="h4 text-bold">Test management</h3>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>Build your testing environment with the tools offered by ElasTest</strong><hr class="doc-features">Easily connect all the components wherever they are and run your tests in a few clicks</p>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon icon-xlg icon-circle icon-carrot-filled fa fa-line-chart icon-primary"></span>
        <h3 class="h4 text-bold">Metrics monitoring</h3>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>Get useful information from all your components</strong><hr class="doc-features">Every test, web browser, database, application... generates logs and consumes computing resources. And knowing when and how they change can give you a huge advantage as a tester</p>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon icon-xlg icon-circle icon-carrot-filled fa fa-chrome icon-primary"></span>
        <h3 class="h4 text-bold">Web browsers</h3>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>Any browser. Of any version</strong><hr class="doc-features">As testers we know how hard it is to ensure that our applications work properly in all browsers and versions. ElasTest makes this an easy task</p>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50"><span class="icon icon-xlg icon-circle icon-carrot-filled fa fa-sort-amount-desc icon-primary"></span>
        <h3 class="h4 text-bold">Log analyzer</h3>
        <p class="inset-sm-left-15 inset-sm-right-15"><strong>A powerfool tool for finding what you want in the vast flood of logs</strong><hr class="doc-features">Gathering logs is only the first step. None of this would make sense if you couldn't dive into your logs with a powerful, intuitive and adaptative tool as ElasTest Log Analyzer</p>
    </div>
</div>

<h4 class="holder-subtitle link-top" id="elastest-core-concepts">ElasTest core concepts</h4>

<p>
ElasTest is built around 3 main elements:

<div style="margin-top: 30px">
    <h4 id="sut" class="link-top">SuT</h4>
    Software under Test: the tested software itself. ElasTest supports two kinds of SuTs:
    <ul>
        <li><strong>Dockerized SuT</strong>: your software is hosted inside Docker container/s
            <ul>
                <li><i>Docker image</i>: SuT is packaged as a single docker image. The name of the image must be specified. If the docker image is not located in DockerHub, then the image name contains the FQDN of the registry.</li>
                <li><i>Docker compose</i>: SuT is composed by several containers and is defined with a <i>docker-compose.yml</i> file.</li>
            </ul>
        </li>
        <li><strong>Deployed Sut</strong>: your software is already deployed somewhere on the cloud
            <ul>
                <li><i>Manual instrumentation</i>: ElasTest won't gather any monitoring information from the SuT unless you manually install some agents</li>
                <li><i>Automated instrumentation</i>: let ElasTest configure your deployed SuT to send metrics and logs</li>
            </ul>
        </li>
    </ul>
</div>

<div style="margin-top: 30px">
    <h4 id="tjob" class="link-top">TJob</h4>
    Test Job: test to be executed against a piece of software (SuT). In a TJob several things have to be specified:
    <ul>
        <li><i>Environment needed to execute the tests</i>: This is defined with a docker image that contains all tools used by the tests.</li>
        <li><i>How to retrieve and execute the tests</i>: Specified as a set of commands written in bash that will be executed inside the environment defined before (docker container).</li>
        <li><i>The SuT against which tests are executed</i>: That is, the SuT description. If the Sut is already deployed, it is necessary to specify how to reach it (usually with its IP). If the SuT lifecycle is managed by ElasTest, ElasTest needs to know how to deploy and undeploy the SuT.</li></br>
    A TJob can be executed several times. That can be useful, for example, because SuT has changes and we want to verify that old features are still working. Or if we add more tests to the same TJob test repo, we can execute them against the SuT. For unit and integration tests, TJobs can manage themselves the deployment of the tested software (SuT not necessary). To learn more about this, you can check our <a href="/docs/testing/unit/">unit test tutorial</a>.
    </ul>
</div>

<div style="margin-top: 30px">
   <h4 id="tss" class="link-top">TSS</h4>
   Test Support Services: services offered by ElasTest to ease the execution and analysis of TJobs. At the moment, only <strong>web browsers</strong> are provided, but in the near future ElasTest will offer other services as <strong>mobile devices emulators</strong>, <strong>IoT devices</strong>, <strong>security services</strong> and <strong>Big Data services</strong>.
</div>

<blockquote>
These three elements are the core concepts of ElasTest platform and they are also the <strong>components targeted</strong> by ElasTest platform.
<br>
In other words: <strong>SuT's, TJob's and TSS's are the modules that ElasTest can monitor and analyse for you</strong>. You can gather information and check logs and metrics for any SuT, TJob or TSS. To learn more check <a href="/docs/monitoring">Monitoring</a> section.
</blockquote>

</p>

<h4 class="holder-subtitle link-top">ElasTest technologies</h4>

<img src="./images/elastest-tech.png" alt="ElasTest technologies" class="img-responsive reveal-inline-block offset-top-10" style="border: none">

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
