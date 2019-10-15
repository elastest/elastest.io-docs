<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Environment variables</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

| Variable name | Description | Sample value | Available when | Accesible from |
| --- | --- | --- | --- | --- |
| **ET_SUT_HOST** | IP of th SuT. Can be used inside the TJobs to connect to the SuT | "172.18.0.16" | There's a SuT configured for the TJob | TJob |
| **ET_SUT_PORT** | Port of th SuT. Can be used inside the TJobs to connect to the SuT | "8080" | There's a SuT configured for the TJob | TJob |
| **ET_SUT_PROTOCOL** | Protocol of th SuT. Can be used inside the TJobs to connect to the SuT | "http" | There's a SuT configured for the TJob | TJob |
| **ET_NETWORK** | The name of the docker network to which the elastest containers belong | "elastest_elastest" | ElasTest started | TJob |
| **ET_EUS_API** | HTTP endpoint to launch remote web drivers from the TJobs | "http://172.18.0.14:8040/eus/v1/" | Web Browser Service is enabled for the TJob | TJob |
| **ET_MON_LSHTTP_API** | Logstash API URL to send http requests with custom monitoring information to ElasTest | "http://172.18.0.12:80/logstash/" | Always available | TJob, SuT, TSS |
| **ET_MON_LSHTTPS_API** | Logstash Secure API URL to send http requests with custom monitoring information to ElasTest | "http://172.18.0.12:443/logstash/" | Always available | TJob, SuT, TSS |
| **ET_MON_EXEC** | The execution identifier to set the value of _exec_ field when sending http requests with custom monitoring information to ElasTest| "s1_e1" | Always available | TJob, SuT, TSS |
| **ET_SUT_CONTAINER_NAME** | SuT container name | "sut_37" | Always available | TJob, SuT, TSS |
| **ET_MON_INTERNAL_LSBEATS_PORT**  |  Port through which traces are sent to logstash | "5037" | Always available | TJob, SuT, TSS |
| **ET_SUT_LOG_TAG** | It allows us to assign a label in the log driver output of the SuT container. This tag contains information that ElasTest uses internally to identify logs | "sut_37_exec" | Is an external TJob | TJob |
| **ET_ETM_TJOB_ATTACHMENT_API** | It contains an api url that allows us to attach evidence files to the execution | "http://172.18.0.1:37000/api/tjob/exec/707/attachment" | Always available | TJob |
| **ET_TEST_CONTAINER_NAME** | TJob container name | "test_37" | Always available | TJob |

<br>
* **TSS**: Test Support Services