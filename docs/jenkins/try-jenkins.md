<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Try Jenkins Plugin</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>


Once started ElasTest, you can make use of the Jenkins instance provided, which contains some example jobs loaded by default.

If you did not start ElasTest with the **`--jenkins`** parameter (see how to [start ElasTest](/try-elastest) and its parameters), the Jenkins instance will not be available but you can start it manually from the ElasTest GUI navigating to the **`Jenkins`** section and clicking on the **`Start Jenkins`** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"/></a>
</div>

Jenkins start progress will be shown:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_starting.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_starting.png"/></a>
</div>

Once started, a button to open Jenkins in a new browser tab and another button to show the access credentials will be shown (If you started Jenkins with ElasTest --jenkins parameter, these buttons will be displayed directly)

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_started_marked.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Your first Job with Jenkins Plugin</h4>

<h5 class="small-subtitle">1. Access Jenkins</h5>

Open Jenkins by clicking on the button and enter your login credentials, you will see some demo Jobs:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_main_with_demos.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_main_with_demos.png"/></a>
</div>

<h5 class="small-subtitle">2. Get into "jenkins-junit5-unit-test" Job</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_junit_example_main.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_junit_example_main.png"/></a>
</div>

<h5 class="small-subtitle">3. Click to "Build now" button</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_junit_example_main_build_btn.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_junit_example_main_build_btn.png"/></a>
</div>


<h5 class="small-subtitle">4. Running view</h5>

After pressing the button, you will see the job running on Jenkins:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_junit_example_running.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_junit_example_running.png"/></a>
</div>

On the other hand, ElasTest will have created a project called **`Jenkins Examples`** in **Projects section**, that will contain a TJob with the same name as Jenkins Job (jenkins-junit5-unit-test). 

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/elastest_jenkins_project.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/elastest_jenkins_project.png"/></a>
</div>

Navigating to this TJob you can see the current execution:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/elastest_junit_example_running.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/elastest_junit_example_running.png"/></a>
</div>

<h5 class="small-subtitle">5. Results view</h5>

Once the execution is complete, you can view it in both Jenkins and ElasTest

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_junit_example_end.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_junit_example_end.png"/></a>
</div>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/elastest_junit_example_end.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/elastest_junit_example_end.png"/></a>
</div>

As can be seen in the last image, ElasTest shows different information, such as **test results** or **logs**. You can also see a card of metrics (All Metrics), but in this particular test is not sent any so it will appear empty.