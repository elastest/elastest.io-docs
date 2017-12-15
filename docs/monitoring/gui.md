<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Monitoring user interface</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

ElasTest provides testers with a direct way of customizing their dashboards on TJob executions, so they can see only the metrics and logs that matter to them.

During any TJob execution, you can add so many logs and metrics you want by clicking the Monitoring Configuration button:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/monitoring/images/monitoring_conf.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/monitoring_conf.png"/></a>
</div>

There you can find all the monitoring choices available for that specific TJob exexcution.
For example, for this TJob we are adding 3 different log streams:

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

When clicking on "Apply" button, you will see one monitoring card for each selected option (a log card for each log and a chart card for each metric). If you want to save your current monitoring configuration for future executions of the same TJob, you just need to press "Apply and Save" button instead. Thus, each time you launch that TJob you will see the same logs and graphs. This can be useful for regression tests, as you can compare the same information from two diffrent executions of the same TJob.

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
