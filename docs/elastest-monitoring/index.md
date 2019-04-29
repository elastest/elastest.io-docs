<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Elastest Monitoring</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest is able to monitor the health of various of its components. Monitoring capabilities can be divided in two areas:

-   **Resource usage**: Monitors CPU, memory and other component metrics.
-   **Component containers**: Monitors docker status and logs.

<h3 class="holder-subtitle link-top">Resources usage</h3>

ElasTest is able to monitor the health of various of its componets and allows correlated queries aiding the fault location within the platform in an optimized manner.

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

In the figure above, on the top left we have a summary of the running containers' metrics. On the top right we see the active containers and the workload it represents for the node on the color scale. Finally, underneath, we have specific metrics for the node such as network activity, CPU usage and memory.

Moreover, if we hover over the plots, we use the mouse pointer to observe the values for a specific time in the metrics plot, as seen in the following figure:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/elastest-monitoring/images/img07.png"><img class="img-responsive img-wellcome" src="/docs/elastest-monitoring/images/img07.png"/></a>
</div>

<h3 class="holder-subtitle link-top" id="componentContainers">Component containers</h3>

View <a href="/docs/manage-elastest/monitoring-containers/"> Monitoring Containers </a> section (into Manage ElasTest)
