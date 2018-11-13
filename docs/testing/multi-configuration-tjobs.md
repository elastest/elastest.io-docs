<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Multi-Configuration TJobs</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest provides a simple way of execute same TJob with different configurations, compare several executions and improve visualization with matrices and graphs (Basic Orchestration).

For this it is necessary to activate the "multi" option in the TJob creation page:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_1.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_1.png"/></a>
</div>

A Multi-Configuration field is formed by a name and one or more values. Each name-value pair represents an environment variable with its name and its value.

Add new Multi-Configurations to a TJob when creating/editing it, typing the name of the configuration and adding as many values as you want to test:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_2.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_2.png"/></a>
</div>
Save the TJob and you can run it.

ElasTest provides an example TJob Multi-Configuration within the WebApp project, called **`Multi WebApp`**. This TJob has a single configuration named **`BROWSER`** with two values: **`chrome`** and **`firefox`**.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_3.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_3.png"/></a>
</div>

Therefore there will be two executions, one for each value, in which the corresponding browser will be used. During the execution of the Multi-Configuration tJob the following screen will be displayed, in which you can see information on the execution of each configuration (in this case two):

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_4.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_4.png"/></a>
</div>

By clicking on each of them you can see the execution page of that configuration:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_5.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_5.png"/></a>
</div>

Once the executions are finished, the results screen will be displayed, in which you can view general information of all the executions presented in multiple ways: You can see it as a list or table of configurations executions and as a test table.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_6.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_6.png"/></a>
</div>

The charts will show a line for each configuration, to be able to compare quickly:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_7.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_7.png"/></a>
</div>

<h3 class="holder-subtitle link-top">Advanced Configuration</h3>
You can configure your tests to send marks to ElasTest, so you can make better comparisons in the charts later.
To send a mark to ElasTest, you must print a log line for each mark in your test with the following exact structure: **`##elastest-monitor-mark: id=MARKID, value=MARKVALUE`** replacing MARKID with the common id of the mark and MARKVALUE for the value of the mark at that time. There will be a different chart display for each mark id.

In the TJob "Multi WebApp" test several marks are sent with `id=action`, therefore, in the test results page we will have the option to visualize the charts as **"action" Mark View** or as **Time View** (default). By clicking on **"action" Mark View** button we will have the following view, in which each point of the chart corresponds to each mark sent:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/multi/multiconfig_8.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/multi/multiconfig_8.png"/></a>
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
