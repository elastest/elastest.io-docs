<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Executions Comparator</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest has a TJob Execution comparator which allows you to see the differences between two or more executions at a glance.

<h3 class="holder-subtitle link-top">Accessing Executions Comparator</h3>

To access the run comparator you must first navigate to the corresponding **TJob section**.

Once there you will have to **select two or more finished executions** from the table and finally press the <strong class="etColor">Compare executions</strong> button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/accessing.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/accessing.png"/></a>
</div>

<h3 class="holder-subtitle link-top">Using the Executions Comparator</h3>

Once inside the execution comparator the following information will be displayed:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/executions_comparator.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/executions_comparator.png"/></a>
</div>

<h4 class="small-subtitle holder-subtitle link-top">Executions to compare</h4>

A list with information about **each execution** will be displayed here. You will be able to click on each one of them to navigate to the page of that execution.

<h4 class="small-subtitle holder-subtitle link-top">Test Cases Comparison</h4>

Here you can see a table with the <strong class="etColor">results of each test case</strong> in **each of the executions**.

<h4 class="small-subtitle holder-subtitle link-top">Monitoring Traces Comparison</h4>

On the other hand, you can also make a comparison of the <strong class="etColor">metrics and logs</strong> of the executions. To do this, you can select the logs and/or metrics that you want to compare in the **Monitoring Configuration** window (by pressing the nut-button on the upper right-hand side) as you would on the screen of a tjob run. Once added they will be shown as follows:

<h5 id="log-comparator" class="small-subtitle">Log Comparator</h5>

To compare logs you must first select the logs you want to compare:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/log_comparator/lc1.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/log_comparator/lc1.png"/></a>
</div>

Once added you will see the following card:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/log_comparator/lc2.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/log_comparator/lc2.png"/></a>
</div>

In this card there will be **a tab for each log selected** and if you select more than one there will be another tab called **AIO that mixes all the logs selected**.

In addition, within **each of these tabs** there will be one tab **for each pair of selected executions** (in this example we have only selected two, so there will only be one tab).

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/log_comparator/lc3.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/log_comparator/lc3.png"/></a>
</div>

There are several possible filters that are divided into two categories:

-   **`View`**:
    -   **Complete logs**: compare all available logs. *(Default)*
    -   **Test Logs**: compare only the logs of the test cases.
    -   **Failed Tests**: compare only the logs of the failed test cases.
-   **`Comparison`**:
    -   **Complete**: displays the complete message as it is saved.
    -   **No timestamp**: if the message contains timestamp, removes it. *(Default)*
    -   **Time diff**: includes the time diff between traces in the logs comparison.

To start the check you should press the button Start Comparison:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/log_comparator/lc4.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/log_comparator/lc4.png"/></a>
</div>

The comparison will be shown:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/log_comparator/lc5.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/log_comparator/lc5.png"/></a>
</div>

If we select the Test Logs view:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/log_comparator/lc6.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/log_comparator/lc6.png"/></a>
</div>

<!-- Metrics -->
<h5 class="small-subtitle">Metrics Comparator</h5>

To compare metrics you must first select the metrics you want to compare:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/mc1.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/mc1.png"/></a>
</div>

Once added you will see the following card:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/mc2.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/mc2.png"/></a>
</div>

<h6 class="smaller-subtitle">Advanced Metrics Configuration</h6>
You can configure your tests to send marks to ElasTest, so you can make better comparisons in the charts later.
To send a mark to ElasTest, you must print a log line for each mark in your test with the following exact structure: **`##elastest-monitor-mark: id=MARKID, value=MARKVALUE`** replacing MARKID with the common id of the mark and MARKVALUE for the value of the mark at that time. There will be a different chart display for each mark id.

In this test example several marks are sent with `id=action`, therefore, in the test results page we will have the option to visualize the charts as **"action" Mark View** or as **Time View** (default). By clicking on **"action" Mark View** button we will have the following view, in which each point of the chart corresponds to each mark sent:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/executions-comparator/images/mc3.png"><img class="img-responsive img-wellcome" src="/docs/executions-comparator/images/mc3.png"/></a>
</div>
