<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Elastest Monitoring</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest can be used to primarily monitor the health of various componets of ElasTest platform and allows correlated queries aiding the fault location within the platform in an optimized manner.

<h3 class="holder-subtitle link-top" id="options">Resources usage</h3>

<h4 class="small-subtitle">Accessing the Monitoring Dashboard</h4>

To visualize the data being monitored, click on the Elastest Monitoring Platform button in the ElasTest dashboard

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/emp_section.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/emp_section.png"/></a>
</div>

<h4 class="small-subtitle">Visualizing the Relevant Metrics</h4>

After accessing the monitoring dashboard, the metrics will be displayed like in the following figure, once the data starts to be collected:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/img06.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/img06.png"/></a>
</div>

In the figure above, we can observe the global hosts, and we can select an individual host in a cluster, to observe its metrics. On the top left we have a summary of the running containers' metrics. On the top right we see the active containers and the workload it represents for the node on the color scale. Finally, underneath, we have specific metrics for the node such as network activity, CPU usage and memory.

Moreover, if we hover over the plots, we use the mouse pointer to observe the values for a specific time in the metrics plot, as seen in the following figure:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/img07.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/img07.png"/></a>
</div>

<h3 class="holder-subtitle link-top" id="options">Containers</h3>

ElasTest also provides in its GUI a section to visualize the **`status`**, the **`general info`** and the **`logs`** of the containers of the **main services** of ElasTest, as well as the version that is being used. You can access this section by clicking on the button with interrogation icon (?):

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/help_button.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/help_button.png"/></a>
</div>

This section looks like this:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/help_page.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/help_page.png"/></a>
</div>

It has two buttons on the top right: the first to manually refresh the information and the second to activate or deactivate the autorefresh of this information.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/help_page_upper_buttons.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/help_page_upper_buttons.png"/></a>
</div>

If you click on the "view logs" button, the last logs of that container will be loaded at the bottom of the page:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/help_page_etm_logs.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/help_page_etm_logs.png"/></a>
</div>

Clicking on the "load previous" button will load all the logs of that container:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/help_page_etm_logs_load_more.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/help_page_etm_logs_load_more.png"/></a>
</div>