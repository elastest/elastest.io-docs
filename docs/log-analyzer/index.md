<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Log Analyzer</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

ElasTest's Log Analyzer service provides an advanced tool for analyzing any log gathered during any finished or running TJob execution.

You can load the logs directly from the page of any TJob execution:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/log-analyzer/images/tjob_exec_link.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/tjob_exec_link.png"/></a>
</div>

Or load so many TJob executions logs as you want by clicking on "Log Analyzer" menu button. A dialog will pop up to let you select the specific TJob execution(s) you want to analyze. To do so:

1. Select the project **Type**
2. Select the **Project** to which the TJob belongs
3. Select the **TJob**
4. Select all the **TJob Executions** you want to load

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/log-analyzer/images/tjob_exec_selection.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/tjob_exec_selection.png"/></a>
</div>

After clicking "OK" button, your logs will load into the Log Analyzer. Every entry is divided into many fields, which include:

- **timestamp**: timestamp of the entry
- **message**: the log entry message
- **level**: the logging level of the entry (DEBUG, INFO, WARNING, ERROR...)
- **component**: component that generated the entry (SuT, TJob, TSS)
- **stream**: specific stream that generated the entry (remember that one single component can generate different logs and metrics)
- **exec**: TJob Execution to which the entry belongs

<br>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/log-analyzer/images/logs.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/logs.png"/></a>
</div>

You can order your columns as you want just by drag-and-dropping.

On the right menu you have the two main tools currently provided by ElasTest Log Analyzer: the **Filter** tool,  the **Mark** tool and the **Config** tool.

<h4 class="holder-subtitle link-top">Filter tool</h4>

Filter tool allows you to do a filtered load of entries. You can filter by:

- **Date**: load logs within a certain time frame, applied to the timestamp of the entries
- **Component/Stream**: load logs produced by certain component(s) for certain stream(s)
- **Level**: load logs of certain level of logging
- **Message**: load logs whose _message_ filed contains certain word

<br>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-5" href="/docs/log-analyzer/images/logs.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/logs.png"/></a>
</div>

Bottom options let you establish the number of entries you want ElasTest to load (the first ones that match your filters).

_Add from last_ and _Add from selected_ will append only the new entries starting from that specific entry.

<h4 class="holder-subtitle link-top">Mark tool</h4>

Mark tool allows you to perform a coloured search in your loaded entries. You can then easily navigate between the entries for each search just by clicking on the arrow buttons for the desired serach.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-6" href="/docs/log-analyzer/images/mark.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/mark.png"/></a>
</div>


<h4 class="holder-subtitle link-top">Config tool</h4>

Config tool allows you to save and load your columns position configuration. Moreover, you can set the row height automatically enabling the last button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-6" href="/docs/log-analyzer/images/mark.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/config.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Known issues</h4>

There's a known issue when log entries have the same timestamp in the order of milliseconds (it can result in data appearing in random order).

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