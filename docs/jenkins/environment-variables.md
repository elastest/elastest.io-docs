<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Environment variables</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

| Variable name | Description | 
| --- | --- |
| **ET_SUT_CONTAINER_NAME** | SuT container name |
| **ET_SUT_MON_LSBEATS_HOST**, **ET_SUT_MON_LSBEATS_PORT**  |  Both variables indicate the port and  address where we send all metric traces through Beats protocol. | 
| **ET_SUT_MON_LSTCP_HOST**, **ET_SUT_MON_LSTCP_PORT** | Both variables indicate the port and  address where we send all log traces through TCP protocol. | 
| **ET_SUT_MON_LSHTTP_API** | Its purpose sends traces through HTTP | 
| **ET_SUT_LOG_TAG** | It allows us to assign a label in the log driver output of the SuT container. This tag contains information that ElasTest uses internally to identify logs. |

