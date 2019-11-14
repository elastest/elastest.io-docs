<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Releases</h2>
</div>
</div>

<!-- ************************* -->
<!-- ********* 2.1.0 ********* -->
<!-- ************************* -->

<h3 id="2.1.0" class="small-subtitle">2.1.0</h3>
<h4 class="smaller-subtitle">14/11/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- Now EUS is able to calculate <a target="_blank" href="/docs/tutorials/using-browsers-in-elastest/#qoe">QoE metrics for video</a>. A new <a href="/docs/demos/qoe" target="_blank">demo project</a> has been added.

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Fixed a bug in <a target="_blank" href="/docs/executions-comparator/#log-comparator">Log Comparator</a> that caused the comparison not to be displayed in the AIO tab (All-In-One).
- **Trim** is now used in the **Parameter fields**, in the creation/edition of TJob/SuT
- The message _"Chrome is being controlled by automated test software"_ is now also hidden in **Chrome browsers** from version **75 onwards**. This caused problems for <a target="_blank" href="/docs/demos/cross-browser-testing">Crossbrowser</a> when used together with other browsers.

<!-- ************************* -->
<!-- ********* 2.0.1 ********* -->
<!-- ************************* -->

<h3 id="2.0.1" class="small-subtitle">2.0.1</h3>
<h4 class="smaller-subtitle">22/10/2019</h4>

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Sut of **Fullteaching demo project** fixed.
- Don't show **tooltip** in GUI **menu elements** when is expanded.

<!-- ************************* -->
<!-- ********* 2.0.0 ********* -->
<!-- ************************* -->

<h3 id="2.0.0" class="small-subtitle">2.0.0</h3>
<h4 class="smaller-subtitle">15/10/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- <a target="_blank" href="/docs/deploying/kubernetes">Kubernetes</a> support is here!
- Great <strong class="italicEtColor">GUI</strong> enhancements:
  - The **`side menu has been collapsed`** by default so that only the icons are displayed.
  - Great changes in the **`finished TJob Execution view`**: Test Results/Test cases are shown in tabs; Global execution data are now colapsed in a Expansion panel; If the execution fails and there are previous successful runs, **Log Comparator** is shown.
    <br>
    <div class="docs-gallery inline-block" style="margin-top: 6px; margin-left: 23px;">
    <a data-fancybox="gallery-1" href="/docs/releases/images/2.0.0/feature_gui_finished_tjobexec_page.png"><img class="img-responsive img-wellcome" style="max-height: 270px;" src="/docs/releases/images/2.0.0/feature_gui_finished_tjobexec_page.png"/></a>
    </div>
  - Now in the log cards it is shown if there are errors or warnings and it is possible to filter them. Errors and warnings are also coloured.
    <div class="docs-gallery inline-block" style="margin-top: 6px; margin-left: 23px;">
     <a data-fancybox="gallery-1" href="/docs/releases/images/2.0.0/feature_gui_log_card_error.png"><img class="img-responsive img-wellcome" style="max-height: 270px;" src="/docs/releases/images/2.0.0/feature_gui_log_card_error.png"/></a>
    </div>
  - **Space** between cards and other elements **`has been reduced`**.
  - Now you can **select several TJobs** and **`delete them all at once`** in the Project section.
  - The **`number of TJobs and Suts`** contained in a project is now **shown** in the global project table.
  - Now you can **`resize some cards`** like Browser card in <a target="_blank" href="/docs/testlink">TestLink</a> Test Plan execution.
  - Now the **Sut Id** is shown in **`TJobExecution`** views and tables
  - **`Network traces`** received by **Metricbeat** can be displayed now.
  - It's possible to **`collapse the LogAnalyzer menu`**.
  - **`Angular`** has been updated to version **`8`** and **`Covalent to 2.1.1`**.
- <a target="_blank" href="/docs/testlink">TestLink</a> Improvements:
  - Now you can **`pause and resume`** a Test Plan Execution.
  - Test Plans can now be executed with <a target="_blank" href="/docs/demos/cross-browser-testing">Crossbrowser</a>.
  - External TJob Execs (**Test Plan Executions**) can now **`be removed`**.
  - ElasTest Security Service (**ESS**) can now be **`used in Test Plan Execution`**.
- New <a target="_blank" href="/docs/testing/environment-variables/">environment variable</a> is available in the TJob: **`ET_TEST_CONTAINER_NAME`**.
- Dockbeat collects now **`Browser container metrics`**.
- On **remove** TJobExec, TJob or External TJob Exec its **folders** associated with its content **`are deleted`**.
- The version of the **ElasTest Browsers** has been updated to **`2.1.0`**.
- It is now possible to deploy <a target="_blank" href="/docs/tutorials/using-browsers-in-elastest/#browsersInAWS">ElasTest browsers in AWS</a>.
  - A <a target="_blank" href="/docs/demos/load-testing-with-aws/">demo project</a> has been added
- The **download of executions as JSON** has been **`improved`**: now the logs and metrics of each test case are downloaded, in case of having start / finish traces that limit them

<h5 class="smaller-subtitle">Bug Fixes</h5>

- <a target="_blank" href="/docs/testlink">TestLink</a>:
  - Fixed the bug that, **when synchronizing** TestLink data, **`removed start/end date`** from ExternalTestExecution (Test Plan Execution).
  - Now the **`browser logs are retrieved`** again in Test Plans with Suts.
  - Fixed bug that **incorrectly** established the **names of internal Suts containers** in ExternalTJobExecutions (Test Plan Execution), which caused the **`logs not to be saved`**.
- <strong class="italicEtColor">GUI</strong>:
  - Fixed bug in the section of a <strong class="italicEtColor">specific Project</strong> that **when duplicating or deleting a TJob** did **`not reload the list`** and had to re-navigate to see the changes.
  - Fixed a bug with **some metricbeat charts**, which only added one of the subtypes
  - There was a bug in the **Metric Cards** that when you remove one of them **`the one that wasn't was removed`**.
  - Other **little fixes**.
- <strong class="italicEtColor">EUS</strong>:
  - Solved **`concurrency problem on send messages`** through the **same websocket**.
  - Fixed bug in which when a **request to the browser** returned a code **other than 200**, an **`exception`** was launched. This began to give problems with the last versions of chrome (>75) and with Firefox.
  - Fixed a bug that did **`not intercept elastest scripts`** (elastestScript) and therefore, Single Browser test videos were not splitting and naming.
- Now the metric traces sent by each **Dockbeat** are filtered according to their execution id, since when several executions were launched all the dockbeats sent the metrics of all the executions and the information was **multiplied**.

<!-- ************************* -->
<!-- ********* 1.5.0 ********* -->
<!-- ************************* -->

<h3 id="1.5.0" class="small-subtitle">1.5.0</h3>
<h4 class="smaller-subtitle">29/04/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- Added a button to **`download files`** from the browser context during a <a target="_blank" href="/docs/testlink">TestLink</a> Test Plan Execution.
- Now you can select one or more <a target="_blank" href="/docs/testing/sut">Suts</a> and **`delete them all at once`**.
- It is now possible to **`activate/deactivate the All-In-One chart`** from the **Monitoring Configuration** modal window.
- Now when configuring in a <a target="_blank" href="/docs/jenkins">Jenkins</a> job the **maximum number of builds to keep**, this number will be synchronized with the **`maximum number of executions in ElasTest`**.

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Now, in <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a>, the **log traces** are sent to ElasTest with the **`timestamp`**, thus solving the problem of incorrect dates.
- Fixed a bug on the page of a <a target="_blank" href="/docs/testlink">TestLink</a> **Test Case Execution** that brokes the GUI.
- Now when a **test suite** has all its tests skipped, the **`suite is also shown as skipped`** and not as success.
- Fixed a bug in the modal window of an execution of a **TJob with parameters** that, when removing all parameters, the **`button to add more parameters disappeared`**.
- Fixed a bug in <a target="_blank" href="/docs/#modes">singlenode mode</a>: The **Delete red indices** button was **`always disabled`** and could not be pressed even if there were red indices.

<!-- ************************* -->
<!-- ********* 1.4.1 ********* -->
<!-- ************************* -->

<h3 id="1.4.1" class="small-subtitle">1.4.1</h3>
<h4 class="smaller-subtitle">09/04/2019</h4>

<h5 class="smaller-subtitle">Bug Fixes</h5>
-   Fixed a bug in <a target="_blank" href="/docs/executions-comparator/#log-comparator">Log Comparator</a>.
-   Fixed a bug in ElasTest <a target="_blank" href="/docs/#modes">mini</a> that, when running a TJob with EUS and another TSS **did not connect** to the correct url of the EUS WebSocket.
-   Fixed a bug that didn't start the **correct Jenkins version** by starting it with the *-jk* command.

<!-- ************************* -->
<!-- ********* 1.4.0 ********* -->
<!-- ************************* -->

<h3 id="1.4.0" class="small-subtitle">1.4.0</h3>
<h4 class="smaller-subtitle">08/04/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- <a target="_blank" href="/docs/web-browsers/e2e-browser">Browsers started by a TJob</a> run now have a **fixed name**, allowing you to compare browser logs between different **executions**.
- It is now possible to <strong class="italicEtColor">upload files</strong> to a **browser** and also <strong class="italicEtColor">download</strong> them.
- A button has been added to **`upload files to the browser context`** on the <a target="_blank" href="/docs/testlink">TestLink</a> Test Plan **execution** page.
- It is possible to **attach evidence files** to the executions by means of an api that the TJob receives in an <a target="_blank" href="/docs/testing/environment-variables/">environment variable</a> (_ET_ETM_TJOB_ATTACHMENT_API_).
- The **`View in loganalyzer`** button has been added to the section of a **specific Test Case**.

<h5 class="smaller-subtitle">Bug Fixes</h5>
-   Fixed a bug in <a target="_blank" href="/docs/executions-comparator/#log-comparator">Log Comparator</a> that failed to get start/finish traces when testName had special characters or reserved for regex (*:[]$*...).
-   **Browser logs** that contain **line breaks** are now split and combined with the line break character, since it used to give an exception and were not being saved.
-   Definitively fixed <a target="_blank" href="/docs/log-analyzer/">LogAnalyzer</a> date bug with Test Cases.
-   If there is a connection problem on get **browser images** from Docker Hub, the **cached** images are used.

<!-- ************************* -->
<!-- ********* 1.3.1 ********* -->
<!-- ************************* -->

<h3 id="1.3.1" class="small-subtitle">1.3.1</h3>
<h4 class="smaller-subtitle">28/03/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- **Usability** and **performance** <strong class="italicEtColor">enhancements</strong> in TJob Execution page and in the Test Case Execution page of a TJob Execution.

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Fixed the bug where **videos were not played** when they contained **`special characters in their name`**.
- Fixed some bugs in <a target="_blank" href="/docs/log-analyzer/">LogAnalyzer</a>

<!-- ************************* -->
<!-- ********* 1.3.0 ********* -->
<!-- ************************* -->

<h3 id="1.3.0" class="small-subtitle">1.3.0</h3>
<h4 class="smaller-subtitle">20/03/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- The **`maximum number of executions`** can now be configured in the **TJobs**.
- **Usability** and **performance** <strong class="italicEtColor">enhancements</strong>:
  - In the <strong class="italicEtColor">Projects section</strong>, only the **id** and **name** of the projects are brought from the backend instead of bringing all their data.
  - In the section of a <strong class="italicEtColor">specific Project</strong>, up to four times the complete object was being requested from the backend. Now **only what is necessary is requested**.
  - <strong class="italicEtColor">Dashboard</strong> section:
    - The **`Show All`** button has been **replaced by** **`Show 12 more`**.
    - The **`spinner`** is **not shown** when **new information** is obtained.
    - Now the **executions** loaded at the beginning are **`not reloaded again`**.
  - Now in the section of a <strong class="italicEtColor">specific TJob</strong> the **`executions are paginated`**.
- A **new section** has been added: **`Manage Elastest`**. Here you can view the status, the general info and the logs of the <a target="_blank" href="/docs/manage-elastest/monitoring-containers">containers</a> of the core components of ElasTest, as well as the version that is being used. In <a target="_blank" href="/docs/#modes">singlenode mode</a> you can also <a target="_blank" href="/docs/manage-elastest/manage-elasticsearch">manage Elasticsearch indices</a>
- For <a target="_blank" href="/docs/testing/sut/#outsideExternalES">Sut with external Elasticsearch</a>, the user is now allowed to indicate a **`list of fields`** with a **list of values** by which to **filter** to save the traces.
- <a target="_blank" href="/docs/monitoring">Monitoring traces</a> are now removed when deleting a **TJobExecution, TJob, Sut, SutExecution or Project** (the entire index in Elasticsearch for <a target="_blank" href="/docs/#modes">singlenode mode</a> OR the data in Mysql for <a target="_blank" href="/docs/#modes">mini mode</a>)
- **Elasticsearch** has been updated to version <a target="_blank" href="https://www.elastic.co/guide/en/elasticsearch/reference/current/release-notes-6.6.1.html">6.6.1</a> (for <a target="_blank" href="/docs/#modes">singlenode mode</a>)
- Now a **message** is displayed **while logs are loaded** in <a target="_blank" href="/docs/log-analyzer/">LogAnalyzer</a>
- **Stop Session** button added to <a target="_blank" href="/docs/web-browsers/manual-browsers/">WebBrowsers </a> for live sessions.
- For <a target="_blank" href="/docs/web-browsers/outside-testing">testing with Web Browsers from outside ElasTest</a> it is now possible to set a **timeout** to end the session automatically if you do not interact with the browser through selenium after the set time. To do this, it is necessary to make use of the custom capability **`elastestTimeout`**.
- For <a target="_blank" href="/docs/jenkins">Jenkins TJobs</a> the **`Jenkins icon`** is now shown instead of the edit pencil.

<h5 class="smaller-subtitle">Bug Fixes</h5>
-   Fixed the bug that when running several <a target="_blank" href="/docs/web-browsers/e2e-browser">TJob Execs that use EUS</a> showed all sessions within an execution, instead of only showing the corresponding ones.
-   Some minor bugs have been fixed in <a target="_blank" href="/docs/log-analyzer/">LogAnalyzer</a>. Among them it's worth mentioning that it didn't show the full height of a trace that contained line breaks.

<!-- ************************* -->
<!-- ********* 1.2.0 ********* -->
<!-- ************************* -->

<h3 id="1.2.0" class="small-subtitle">1.2.0</h3>
<h4 class="smaller-subtitle">07/03/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- <a target="_blank" href="/docs/executions-comparator/#log-comparator">Log Comparator:</a>
  - Now you can set the **`timeout`** to calculate the diff. Default: 0 (infinite)
  - The **`line numbering`** for the **Tests Logs mode** starts at **1 for each test case** and the line number is **not shown in the name** of the test case.
  - Now the **Complete** mode shows the complete message **as it is saved** (sometimes it has timestamp and sometimes not) and the **Non-timestamp** mode **`removes`** it from messages that contain it.
- <a target="_blank" href="/docs/testlink">TestLink:</a>
  - Added a button to the main table that **`removes`** all synchronized data from elastest and **`resynchronizes`** it.
  - TestLink now allows you to **`select a platform`** when running a Test Plan.
  - **`General improvements`** in stability and styles.

<h5 class="smaller-subtitle">Bug Fixes</h5>

- <a target="_blank" href="/docs/testlink">TestLink:</a>
  - Test cases are now executed **`sorted by id`** during execution and not randomly.
  - Fixed the bug that, if a test case was associated with **more than one test plan**, **`only appeared`** in the Test Plan to which it had been **associated recently**.
  - Now the **url** of an **external sut** **`opens automatically`** in the browser during execution.

<!-- ************************* -->
<!-- ********* 1.1.0 ********* -->
<!-- ************************* -->

<h3 id="1.1.0" class="small-subtitle">1.1.0</h3>
<h4 class="smaller-subtitle">01/03/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- <a target="_blank" href="/docs/executions-comparator/#log-comparator">Log Comparator</a> added in <a target="_blank" href="/docs/executions-comparator/">TJob Executions comparator</a>.
- **Projects/tJobs/Suts/Execs tables** can now be **`sorted`** by columns.
- We have incorporated a **`new code editor`** in the **TJob and Sut edition** for the commands field, instead of using textarea.

<div class="docs-gallery inline-block" style="margin-top: 6px; margin-left: 23px;">
    <a data-fancybox="gallery-1" href="/docs/releases/images/td_code_editor.png"><img class="img-responsive img-wellcome" style="max-height: 270px;" src="/docs/releases/images/td_code_editor.png"/></a>
</div>

- Now all **modal windows** are **`draggable`**.
- TJobExec Test Case **tabs** have now **`lazy load`**.
- Now you can pass a **`list of hosts`** to <a target="_blank" href="/docs/testlink">TestLink</a> browsers to put them in their **/etc/hosts**.
- Improvements in <a target="_blank" href="/docs/testing/sut/#outsideExternalES">Sut with external Elasticsearch</a>.

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Fixed some problems with <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a>.
- Fixed Bug with <a target="_blank" href="/docs/testing/sut/#outsideExternalES">Sut with external Elasticsearch</a> that failed to set an empty path.

<!-- ************************* -->
<!-- ********* 1.0.1 ********* -->
<!-- ************************* -->

<h3 id="1.0.1" class="small-subtitle">1.0.1</h3>
<h4 class="smaller-subtitle">19/02/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- Performance improvements in <a target="_blank" href="/docs/monitoring">saving selected logs and metrics</a>

<h5 class="smaller-subtitle">Bug Fixes</h5>

- The **`Test Case Steps are now shown again`** during the execution of the <a target="_blank" href="/docs/testlink">TestLink</a> test plan .
- Fixed problem with **`browser`** in <a target="_blank" href="/docs/testlink">TestLink</a>that after some time deleted the session automatically.
- Solved problem with <a target="_blank" href="/docs/testlink">TestLink</a> plan execution that when stopping a execution manually the **`correct message`** was not shown because it failed when parsing the DELETE response.
- Fixed bug with <a target="_blank" href="/docs/log-analyzer/">LogAnalyzer</a> that when pressing the button **Reload Log** did not show the content.

<!-- ************************* -->
<!-- ********* 1.0.0 ********* -->
<!-- ************************* -->

<h3 id="1.0.0" class="small-subtitle">1.0.0</h3>
<h4 class="smaller-subtitle">13/02/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- Now when you run a <a target="_blank" href="/docs/testlink">TestLink</a> test plan from ElasTest, you can **`select the browser and the desired version`**.
- Added **`"View in log analyzer" button`** on <a target="_blank" href="/docs/testlink">TestLink</a> test plan execution page.
- **`Metrics`** can now also be compared in the <a target="_blank" href="/docs/executions-comparator/">TJob Executions comparator</a>.
- A button has been added to the **log cards** to **`download`** them as a _.log_ file.
- Now you can select one or more **Projects** and **`delete them all`** at once. You can also do the same with the **TJob Executions**, inside the tJob page.
- Now the search of **logs and metrics** of an execution is done with **`start/end date range`**, which corrects the timeout problem when requesting them.
- Added the **`log-level`** option to the **ElasTest Platform**, so that the user can set the log level of the ETM.
- **`EMS Example`** and **`EDS Example`** demo projects added.
- Updated the integrated <a target="blank" href="/docs/jenkins">Jenkins</a> with the latest version of the <a target="blank" href="https://plugins.jenkins.io/elastest">ElasTest plugin</a>.

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Fixed bug in <a target="_blank" href="/docs/#modes">mini</a> that did not check the correct port of the **`TSS`**.
- Now EUS does not launch an exception when starting a <a target="_blank" href="/docs/web-browsers/manual-browsers/">browser</a> if the maximize command fails.
- Fixed a bug in the **`finished TJob Execution`** page that when clicking in the trash and giving to cancel, the button remained disabled

<!-- ************************* -->
<!-- ****** 1.0.0-beta7 ****** -->
<!-- ************************* -->

<h3 id="1.0.0-beta7" class="small-subtitle">1.0.0-beta7</h3>
<h4 class="smaller-subtitle">31/01/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- ElasTest <a target="_blank" href="/docs/#modes">modes</a> have changed: Now there are two: **mini** and **singlenode**. Cluster mode coming soon.
- Upgrade **ElasTest GUI** to **`Angular 7`**
- **`Autorefresh`** has been added for the TJob Execution tables in the GUI Dashboard.
- **`Test Support Services section`** has been **removed** from all ElasTest modes.
- Now in <a target="_blank" href="/docs/#modes">singlenode</a> an instance of **`EUS is started`** when starting ElasTest and will be used for all executions. This reduces the execution time of TJobs, as they do not have to start an EUS instance, and also the consumption of resources.
- The <a target="_blank" href="/docs/web-browsers/manual-browsers/">WebBrowsers section</a> is now also shown in <a target="_blank" href="/docs/#modes">singlenode</a>, since it has an instance of EUS since the beginning.
- Changes in the way to **`instrumentalize`** an <a target="_blank" href="/docs/testing/sut/#outsideEim">external sut through EIM</a>: Now the Sut is instrumented only during the execution of a TJob.
- Now you can select several TJob runs and **`compare`** their test results.
- <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a> **1.0.0-beta8** released.

<h5 class="smaller-subtitle">Bug Fixes</h5>
-   Solved problem when running several Jobs in a **Jenkins with slaves** that make use of the <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a> at the same time.
-   Fixed bug in <a target="_blank" href="/docs/#modes">mini</a> that did not send the Endpoint environment vars of a TSS to the TJob, necessary for its use.
-   Fixed bug in <a target="_blank" href="/docs/log-analyzer/">LogAnalyzer</a> who didn't check well if TestLink was started and never showed TestLink's projects.

<!-- ************************* -->
<!-- ****** 1.0.0-beta6 ****** -->
<!-- ************************* -->

<h3 id="1.0.0-beta6" class="small-subtitle">1.0.0-beta6</h3>
<h4 class="smaller-subtitle">23/01/2019</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- **`QUEUED status`** has been added for TJob executions that are queued when there are more than 4 simultaneous executions.
- The **`--logs`** option of <a target="_blank" href="/docs/try-elastest/">ElasTest Platform</a> has been removed. The starting logs of ElasTest containers will now be automatically displayed in the logs of the ElasTest Platform container. This also solves container freezing problems.
- General improvements in the **`stability`** of ElasTest

<div class="docs-gallery inline-block" style="margin-top: 6px; margin-left: 23px;">
    <a data-fancybox="gallery-1" href="/docs/releases/images/platform_start_log-1.0.0-beta6.png"><img class="img-responsive img-wellcome" style="max-height: 270px;" src="/docs/releases/images/platform_start_log-1.0.0-beta6.png"/></a>
</div>

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Fixed bug with **Logstash** in <a target="_blank" href="/docs/experimental/">experimental mode</a> that didn't process **WebRTC traces** correctly.
- Fixed bug by running **`several TJobs with browsers`** that made them fail.

<!-- ************************* -->
<!-- ****** 1.0.0-beta5 ****** -->
<!-- ************************* -->

<h3 id="1.0.0-beta5" class="small-subtitle">1.0.0-beta5</h3>
<h4 class="smaller-subtitle">20/12/2018</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- Now you can configure a Sut with parameters in <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a>.
- Now when you specify the use of a <a target="_blank" href="/docs/testing/sut/#outsideExternalES">Sut with external Elasticsearch</a>, you can also set the _`path`_ in which the service is located, if necessary.
- A new <a target="_blank" href="/docs/testing/environment-variables/">environment variable</a> has been added to the TJob execution containers: **`ET_NETWORK`**.
- **Containers** now contain **`labels`** with information to be used by ElasTest.

<h5 class="smaller-subtitle">Bug Fixes</h5>

- Fixed the bug that appeared randomly when running a TJob with EUS
- **ET_SUT_CONTAINER_NAME** <a target="_blank" href="/docs/testing/environment-variables/">environment variable</a> was not being sent to <a target="_blank" href="/docs/testing/sut/#sutInNewContainer">Sut in new container</a>.

<!-- ************************* -->
<!-- ****** 1.0.0-beta4 ****** -->
<!-- ************************* -->

<h3 id="1.0.0-beta4" class="small-subtitle">1.0.0-beta4</h3>
<h4 class="smaller-subtitle">03/12/2018</h4>

<h5 class="smaller-subtitle">Features & Improvements</h5>

- We've made improvements to the <a target="_blank" href="/docs/">Documentation</a>.
- We have improved <a target="_blank" href="/docs/testing/unit/">example projects</a> and added new ones. The technologies used are <a target="_blank" href="https://junit.org/junit5/">Java JUnit5</a>, <a target="_blank" href="https://junit.org/junit4/">Java JUnit4</a>, <a target="_blank" href="https://www.python.org/">Python</a>, <a target="_blank" href="https://jasmine.github.io/">JS Jasmine</a>, <a target="_blank" href="http://www.protractortest.org/#/">JS Protractor</a>, <a target="_blank" href="">Java Karate</a>, <a target="_blank" href="https://docs.cucumber.io/">Java Cucumber</a> and <a target="_blank" href="https://gauge.org/">Java Gauge</a>.
- It is no longer necessary to specify the **`--server-address=localhost`** when running on <a target="_blank" href="/docs/try-elastest/#forMac">MAC</a> or <a target="_blank" href="/docs/try-elastest/#forWindows">Windows</a> (In docker for Windows, in Docker toolbox **`--server-address=$(docker-machine ip)`** is still necessary).
- All active live sessions are now shown in <a target="_blank" href="/docs/web-browsers/manual-browsers">Web Browsers section</a>.
- A <strong class="italicEtColor">button to restore the demo projects</strong> has been added on the project card.
- <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a> has been updated to <strong class="italicEtColor">Java 8</strong>.
- A system of **retries** has been added to send the traces to ElasTest in the <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a>.
- The use of **Suts managed by ElasTest** is allowed now in <a target="_blank" href="/docs/jenkins">ElasTest Jenkins Plugin</a>.
- **Logstash** has been updated to 6.5.0 version (Logstash is only available in Elastest <a target="_blank" href="/docs/experimental">experimental mode</a>)
- Now the tests can use a <a target="_blank" href="/docs/web-browsers/e2e-browser">single browser</a> for all the tests but the videos are associated with each test.

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

- <a target="_blank" href="/docs/try-elastest/">Improvement in requirements.</a> We've been working on the high memory consumption requirements of previous versions, and this new version can be deployed on machines with 8Gb of RAM starting ElasTest in default mode

- <a href="">GUI improvements.</a> Among other small improvements, it should be noted that more information is now shown to the user, such as the percentage of downloading a docker image, either from a tjob, a sut or a browser.

- <a target="_blank" href="/docs/jenkins/">Improvements in Jenkins plugin.</a> It is no longer necessary for the user to start dockbeat and filebeat to send logs and metrics to ElasTest, the plugin is responsible for it now.

- <a target="_blank" href="/docs/jenkins/">Jenkins instance provided by ElasTest.</a> You can use now a Jenkins instance provided by ElasTest, can be started on load ElasTest or later manually from the ElasTest GUI.

- <a target="_blank" href="/docs/testlink/">Improvements in TestLink integration.</a> It is possible to configure a Sut so that ElasTest starts it every time a Test Plan is executed

- <a target="_blank" href="/docs/log-analyzer/">Improvements in log analysis</a>.

- <a href="javascript:void(0);">Bug fixes</a>.

<!-- ************************* -->
<!-- ********* 0.9.1 ********* -->
<!-- ************************* -->

<h3 id="0.9.1" class="small-subtitle">0.9.1</h3>
<h4 class="smaller-subtitle">09/05/2018</h4>

- <a target="_blank" href="/docs/jenkins/">Jenkins integration.</a> You don’t need to abandon your CI tools. Use ElasTest straight from your Jenkins jobs (Freestyle or Pipeline). For instance, if you’re using Pipeline jobs, just wrap up your Pipeline in an elastest step, and you’ll be ready to use all the fancy features we bring to testers and developers, like managed browsers! See our advanced example for a more complex scenario.

- <a target="_blank" href="/docs/testlink/">TestLink integration.</a> TestLink is the most widely used web-based test management tool and ElasTest provides integration with TestLink. With this integration now you can easily record videos and gather logs and metrics when manually running your tests.

- <a target="_blank" href="https://hub.docker.com/u/elastestbrowsers/">New Docker images for browsers.</a> We have been developing a new set of browser Docker images that brings the benefits of both Selenoid and Selenium docker images. These images are ready for some awesome features we will be developing in the following months, like changing browser resolution to adapt better to the desktop of our users.

- <a target="_blank" href="/docs/web-browsers/manual-browsers/">Browser recordings</a> can now be opened as a new tab or on a floating dialog.

- <a target="_blank" href="/docs/log-analyzer/">Our powerful Log Analyzer</a> now remembers previous configurations.

- <a target="_blank" href="/docs/testing/sut/">Generate your SuT on the fly with Commands Containers</a>: a new Docker image can be generated on the fly, and this image will be run as the SuT.

- <a target="_blank" href="/docs/docs/try-elastest/">ElasTest Command line options documented</a> in its own subsection within the installation page.

- <a target="_blank" href="/docs/testing/environment-variables/">Changes in environment variables: the ElasTest endpoint</a> for sending metrics from an external SuT has changed, and the ET_MON_LSHTTP_API environment variable is now available also for Test Support Services.

- <a target="_blank" href="/docs/testing/environment-variables/">There are new environment variables available</a>: ET_SUT_CONTAINER_NAME, ET_MON_INTERNAL_LSBEATS_PORT and ET_SUT_LOG_TAG. Those allows ElasTest to do a better job when identifying what’s coming from which SuT.

- We have changed the name of the status for a TJob that has been stopped manually to STOPPED.
