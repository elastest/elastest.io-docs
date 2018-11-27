<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Freestyle Job</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>


From a standard Jenkins Job, this plugin allows you:

-   Send the logs generated during the build of a Job to ElasTest
-   Request an EUS TSS that provides browsers on demand, which can be used during the build.

To configure a Freestyle Job with ElasTest integrated, you will must select the _Integrate Jenkins with ElasTest_ field. In this case, the _EUS_ field is not required that is why this example do not need a web browser.

To complete this freestyle job, you must download the project inside of this [repository](https://github.com/elastest/demo-projects) and introduce `cd unit-java-test;mvn test` in the **Build command**.

<br>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/job.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/job.png"/></a>
</div>
<br>

<h5 class="small-subtitle">Job result</h5>

After we run the Freestyle Job, we can check the results in both platforms, **Jenkins** and **ElasTest**.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/jenkins/images/jenkins_log.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/jenkins_log.png"/></a>
    <a data-fancybox="gallery-4" href="/docs/jenkins/images/elastest_log.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/elastest_log.png"/></a>
</div>