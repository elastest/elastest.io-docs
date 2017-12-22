<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Monitoring</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

One of the key features of ElasTest is the ability to **show and analyze logs and metrics** of all elements involved in a test. This is particularly interesting for **end-to-end tests**, which usually involve more complex system architectures in distributed environments. For example, suppose a typical three tier web application with a database. A basic e2e test has the following components: the test itself, web browser (or browsers!), web application and database. All those elements can generate logs and metrics of several types (CPU, memory, network packets…). When a test is executed using ElasTest, the tester can see all that monitoring information in the same graphical user interface and with advanced analysis features.

ElasTest monitoring service is based on **event streams**. Every log and metric entry is called an **event**. The collection of events containing information about the same metric or log is called **event stream**. Any SuT, TJob or Service can generate multiple event streams. All of them can be gathered and visualized by ElasTest on useful graphs in real time and stored for future reviewing.

<div class="docs-gallery inline-block" style="width: 100%; text-align: center">
    <a data-fancybox="gallery-1" href="/docs/monitoring/images/monitoring-diagram.png"><img style="max-height: 660px; border: none" src="/docs/monitoring/images/monitoring-diagram.png"/></a>
</div>

For all TJobs and for all SuTs deployed by ElasTest, you will have available by default some useful logs and metrics. This is possible thanks to Docker features of [logs](https://docs.docker.com/engine/reference/commandline/logs/) and [stats](https://docs.docker.com/engine/reference/commandline/stats/), that allow ElasTest to automatically gather monitoring information from the containers. Therefore, this is the easiest and quickest way to monitor your tests.


<h4 id="send-metrics-with-http" class="holder-subtitle link-top">Monitoring user interface</h4>

ElasTest provides testers with a direct way of customizing their dashboards on TJob executions, so they can see only the metrics and logs that matter to them.

During any TJob execution, you can add so many logs and metrics you want by clicking the Monitoring Configuration button:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/monitoring/images/monitoring_conf.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/monitoring_conf.png"/></a>
</div>


There you can find all the monitoring options available for that specific TJob execution. For example, for this TJob we are adding 3 different log streams:

- The default log of our SuT
- The default log of our test
- The browser's console (we are making use of ElasTest Web Browsers service)

And 3 different metrics for the container of our test:

- The CPU usage
- The memory usage
- The number of bytes received from the network per second

</br><div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/monitoring/images/monitoring_sample.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/monitoring_sample.png"/></a>
</div>

When clicking on "Apply" button, you will see one monitoring card for each selected option (a log card for each log and a chart card for each metric).

The available options depend exclusively on the configuration of your TJob:

<div class="range range-xs-center metric-options-row" style="margin-top: 0; text-align: center">
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50 metric-options-col">
        <div>
            <h3 class="h4 text-bold">TJob</h3>
            <div class="docs-gallery inline-block">
                <a data-fancybox="gallery-2" href="/docs/monitoring/images/metrics_1.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/metrics_1.png"/></a>
            </div>
            <p>If your TJob doesn't have a SuT (usually for unit tests), this window will only show the available default logs and metrics for the TJob container.</p>
        </div>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50 metric-options-col">
        <div>
            <h3 class="h4 text-bold">TJob + SuT</h3>
            <div class="docs-gallery inline-block">
                <a data-fancybox="gallery-2" href="/docs/monitoring/images/metrics_2.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/metrics_2.png"/></a>
            </div>
            <p>If your TJob has a SuT deployed by ElasTest, this window will show the available default logs and metrics for both the TJob container and the SuT container(s). If your SuT is a single docker image, only one default log and one set of metrics will be available. If your SuT is a docker-compose, there will be one default log and one set of metrics for each one of the docker containers that make it up.</p>
        </div>
    </div>
</div>
<div class="range range-xs-center metric-options-row" style="margin-top: 0; text-align: center">
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50 metric-options-col">
        <div>
            <h3 class="h4 text-bold">TJob + SuT + Web Browser Service</h3>
            <div class="docs-gallery inline-block">
                <a data-fancybox="gallery-2" href="/docs/monitoring/images/metrics_3.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/metrics_3.png"/></a>
            </div>
            <p>If your TJob has a SuT deployed by ElasTest and makes use of <a href="/docs/web-browsers/e2e-browser/">Web Browser Service</a>, this window will show the available default logs and metrics for the TJob container, the SuT container(s) and the browser(s). ElasTest can show the browser's console and its metrics as it would do with any TJob/SuT log or metric.</p>
        </div>
    </div>
    <div class="cell-xs-10 cell-sm-6 cell-md-6 offset-top-50 metric-options-col">
        <div>
            <h3 class="h4 text-bold">TJob + SuT outside ElasTest</h3>
            <div class="docs-gallery inline-block">
                <a data-fancybox="gallery-2" href="/docs/monitoring/images/metrics_4.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/metrics_4.png"/></a>
            </div>
            <p>If your TJob has a SuT deployed outside ElasTest, this window will show the available default logs and metrics for the TJob and all the logs and metrics you are sending from your already deployed SuT (if any). Only the logs and metrics sent during the TJob execution will be available. Check <a href="/docs/monitoring/outside-elastest/">Monitoring outside ElastTest</a> and <a href="/docs/monitoring/custom/">Custom monitoring</a> sections to learn more.</p>
        </div>
    </div>
</div>

 If you want to save your current monitoring configuration for future executions of the same TJob, you just need to press "Apply and Save" button. Thus, each time you launch that TJob you will see the same logs and graphs. This can be useful for regression tests, as you can compare the same information from two diffrent executions of the same TJob.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/monitoring/images/apply_and_save.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/apply_and_save.png"/></a>
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
    loop: true,
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
