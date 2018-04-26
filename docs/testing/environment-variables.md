<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Environment variables</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

| Variable name | Description | Sample value | Available when | Accesible from |
| --- | --- | --- | --- | --- |
| ET_SUT_HOST | IP of th SuT. Can be used inside the TJobs to connect to the SuT | "172.18.0.16" | There's a SuT configured for the TJob | TJob |
| ET_EUS_API | HTTP endpoint to launch remote web drivers from the TJobs | "http://172.18.0.14:8040/eus/v1/" | Web Browser Service is enabled for the TJob | TJob |
| ET_MON_LSHTTP_API | Logstash API URL to send http requests with custom monitoring information to ElasTest | "http://172.18.0.12:80/logstash/" | Always available | TJob, SuT |
| ET_MON_LSHTTPS_API | Logstash Secure API URL to send http requests with custom monitoring information to ElasTest | "http://172.18.0.12:443/logstash/" | Always available | TJob, SuT |
| ET_MON_EXEC | The execution identifier to set the value of _exec_ field when sending http requests with custom monitoring information to ElasTest| "s1_e1" | Always available | TJob, SuT |
