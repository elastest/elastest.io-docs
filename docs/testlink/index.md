<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">TestLink</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

TestLink is the most widely used web-based test management tool and ElasTest provides integration with TestLink. With this tool you will can easily catch videos, logs, metrics to our manual execution of the test.

TestLink GUI is accessible from ElasTest. When ElasTest is started, a TestLink instance is also started to allow us the management of manual test.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/testlink/images/testlink_web.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testlink_web.png"/></a>
</div>

Another feature that provides the integration between Elastest and TestLink is the possibility to access from the notes of a test case in TestLink to its execution in Elastest.


<h4>TestLink UI in ElasTest</h4>

The GUI provided by ElasTest to execute the manual test cases has the following sections:

* TestLink Home
* TestLink Projects
* TestLink Test Plan
* TestLink Test Plan Execution
* TestLink Test Plan Execution Results

<h5 class="small-subtitle">TestLink Home</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/testlink/images/testlink.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testlink.png"/></a>
</div>


Clicking TestLink button in left side menu of ElasTest will display the TestLink page.

Here, you can see all your projects created. Moreover, if you want to synchronize the displayed data in ElasTest with the TestLink data, you can use the synchronize button located on the top right.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/testlink/images/testlink_home.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testlink_home.png"/></a>
</div>

<h5 class="small-subtitle">TestLink Project</h5>

This page will allow you to have an overview of all the components of the project, such as Test Suites, Test Plans and SuTs. In addition, you can run a test plan or create a new SuT.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/testlink/images/testlink_project.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testlink_project.png"/></a>
</div>

<h5 class="small-subtitle">TestLink Test Plan</h5>

On this page, not only can you see all the information about the Test Plan, but you can also edit it by clicking on the edit button located at the top.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/testplan_edit.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testplan_edit.png"/></a>
</div>

You can associate a SuT previously created in the editing page.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/edit_testplan.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/edit_testplan.png"/></a>
</div>

<h5 class="small-subtitle">TestLink Test Plan Execution</h5>

On the other hand, you can run the test plan clicking the "Execute Test Plan" button located on the top right. Immediately after clicking on the button, a modal will be displayed and you must select a build to run the test.

You must wait a few seconds until the browser loads. After that, you can see the Test Plan information on the left and a web browser on the right. On the bottom, you will can see all the logs of your test.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/testplan_execute.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testplan_execute.png"/></a>
</div>

If you have associated a Sut to the Test Plan, you must wait until the Sut is ready to be used, then the browser will start as indicated in the previous paragraph and the url of the Sut will be loaded in that browser to test.

When your test is finished, you must fill the fields for each Test Case and click "Save & Next" button.

<h5 class="small-subtitle">TestLink Test Plan Execution Result</h5>

Once you have completed all the test cases you will can see an overview of your test executed.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/execution_view.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/execution_view.png"/></a>
</div>



<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/execution_files.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/execution_files.png"/></a>
</div>
The video recordings of these are shown at the bottom of this page.

If you click on a Test Case Execution, you will see specific information about it, such as the start and end dates, its status, notes, records and video recordings.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/execution_details.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/execution_details.png"/></a>
</div>

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.2.5/jquery.fancybox.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.2.5/jquery.fancybox.min.js"></script>

<script>
var galleries = $('div.docs-gallery');
for (var i = 1; i <= galleries.length; i++) {
    $().fancybox({
    selector : '[data-fancybox="gallery-' + i + '"]',
    infobar : true,
    arrows : false,
    loop: false,
    protect: true,
    transitionEffect: 'slide',
    buttons : [
        'close'
    ],
    clickOutside : 'close',
    clickSlide   : 'close',
  });
}
</script>