<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Manage Elasticsearch (Only for singlenode mode)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

In <a href="/docs/#modes">ElasTest singlenode mode</a>, Elasticsearch is used to store the monitoring information of the executions. In the **Manage Elasticsearch** section all Elasticsearch indexes can be displayed, as well as indexes that have a **red state**. When there are indexes in this state, Elasticsearch gives problems and ElasTest cannot load logs and metrics of the executions, so it is **necessary to remove** these indexes. To do this you would have to press the **Delete Red Indices** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/manage-elastest/images/red-indices.png"><img class="img-responsive img-wellcome" src="/docs/manage-elastest/images/manage-elasticsearch/red-indices.png"/></a>
</div>
