<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">TestLink</h2>
<div class="offset-top-30 offset-md-top-30">
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

-   TestLink Home
-   TestLink Projects
-   TestLink Test Plan
-   TestLink Test Plan Execution
-   TestLink Test Plan Execution Results

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

On the other hand, you can run the test plan clicking the "Execute Test Plan" button located on the top right. Immediately after clicking on the button, a modal will be displayed in which you can select the next configuration:

-   **Select Build** to run the test.
-   **Select Browser and it's version**.
    -   You can check **`Enable Cross browser`** to use multiple browsers. View demo <a href="/docs/demos/cross-browser-testing" target="_blank">here</a>
-   **Select a Platform**.
-   **Configure a hosts list** to put them in the browser container **/etc/hosts**.
    <p></p>
    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-4" href="/docs/testlink/images/execute_plan_modal.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/execute_plan_modal.png"/></a>
    </div>

Once the configuration has been selected and the _Run test plan button_ has been pressed, you must wait a few seconds until the browser loads. After that, you can see the Test Plan information on the left and a web browser on the right. On the bottom, you will can see all the logs of your test.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/testplan_execute.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testplan_execute.png"/></a>
</div>

If you have **`associated a Sut`** to the Test Plan, you must wait until the Sut is ready to be used, then the browser will start as indicated in the previous paragraph and the url of the Sut will be loaded in that browser to test.

If you need to **`attach files`** you have on your machine to your browser, you can add them to the browser context by using the **Upload files to browser context** button. You can select more than one file at a time. Once uploaded to the browser context, you can find them in _/home/ubuntu/et_shared_files_.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/testplan_execute_uploadfile.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/testplan_execute_uploadfile.png"/></a>
</div>

It is also possible to **`obtain a file`** from the context of the browser, making use of the **Download file from browser context** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/download_file_btn.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/download_file_btn.png"/></a>
</div>

Clicking will open a **modal window** where we can enter the **`full path`** where the file is within the context of the browser:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/download_file_path.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/download_file_path.png"/></a>
</div>

Once the route has been entered, just click on the DOWNLOAD button and the file will be downloaded.

To **`run Test Cases`**, you must fill the fields for each and click **Save & Next** button.

It's possible to **`pause`** an execution, and resume it later. In order to do this it is necessary to have **executed at least one test case**. From that moment on, a button to pause the execution will appear in the interface.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/plan_execution_pause.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/plan_execution_pause.png"/></a>
</div>

To resume it, navigate to Plan page and click to resume button:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/testlink/images/plan_execution_resume.png"><img class="img-responsive img-wellcome" src="/docs/testlink/images/plan_execution_resume.png"/></a>
</div>

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
