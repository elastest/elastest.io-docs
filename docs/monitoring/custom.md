<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Custom monitoring</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

ElasTest automatically gathers metrics and logs from all TJobs and from all SuTs deployed by the platform itself (dockerized SuTs), as explained [here](/monitoring/). And ElasTest allows configuring already deployed SuTs for sending metrics and logs thanks to Beats technology, as explained [here](/monitoring/outside-elastest/). But what if you want to send some custom information to ElasTest to be shown or graphed during a TJob execution? For example:

- If your SuT is a web application, the code in your TJob can send the number of users connecting to it as it executes so you can compare it with the CPU consumption or memory usage of the SuT.
- If you are interested in a specific metric of your SuT for which there's no Beat agent available ([official agents](https://www.elastic.co/products/beats) or [community agents](https://www.elastic.co/guide/en/beats/libbeat/current/community-beats.html)), you can always send it through http.

For this reason, ElasTest allows users to send any log or metric through http requests.

<h4 id="send-metrics-with-http" class="holder-subtitle link-top">Send metrics with HTTP</h4>

You can send to ElasTest metric information with http requests from any TJob or any SuT.

<h5 class="small-subtitle">IP of http request in a TJob or a SuT deployed by ElasTest</h5>

Value of environment variable *`ET_MON_LSHTTP_API`*.

<h5 class="small-subtitle">IP of http request in a SuT deployed outside ElasTest</h5>

The URL can be built with **HTTP Api Url** param, available from the SuT information page:

<div class="docs-gallery more-margin-top inline-block">
    <a data-fancybox="gallery-2" href="/docs/monitoring/images/logstash_ip.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/logstash_ip.png"/></a>
</div>

For to the image above, the URL where to send the post requests would be:

```text
http://172.18.0.11:80/logstash/
```

<br>

The request has to use the POST method. There are different formats to send different types of information:

<h5 class="small-subtitle">Send one log entry in one request</h5>

```json
{
   "@timestamp": 9999999999,
   "exec": "XX",
   "component": "YY",
   "stream": "ZZ",
   "message": "Complete log message entry"
}
```
<div style="margin-top: 20px"></div>

- **@timestamp**: is optional and contains the timestamp when event was generated.
- **exec**: The value of **Exec ID** shown in ElasTest dashboard for SuTs deployed outside ElasTest or the value of `ET_MON_EXEC` environment variable for TJobs or SuTs deployed by ElasTest.
- **component**: `sut` for http requests sent from the SuT and `test` for http requests sent from the TJob.
- **stream**: Used to distinguish several logs from the same component. In this case only one log exists for the component, its value is usually "default_log".
- **message**: Complete log message entry.

<h5 class="small-subtitle">Send several log entries in one request</h5>

```json
{
   "@timestamp": 9999999999,
   "exec": "XX",
   "component": "YY",
   "stream": "ZZ",
   "messages": [
      "Complete log message entry 1",
      "Complete log message entry 2",
      "Complete log message entry 3",
      "Complete log message entry 4"
   ]
}
```

<h5 class="small-subtitle">Send one atomic metric in one request</h5>

```json
{
   "@timestamp": 9999999999,
   "exec": "XX",
   "component": "YY",
   "stream": "cpu_usage",
   "stream_type": "atomic_metric",
   "cpu_usage": 80,
   "unit": "%"
}
```

<div style="margin-top: 20px"></div>

- **stream** field can be whatever you want (it has to be used below when setting the numeric value)

<h5 class="small-subtitle">Send one composed metric in one request</h5>

```json
{
   "@timestamp": 9999999999,
   "exec": "XX",
   "component": "YY",
   "type": "cpu",
   "stream_type": "composed_metric",
   "cpu": {
     "total_usage": 80,
     "max_usage": 100
   }
   "units": {
     "total_usage": "%",
     "max_usage": "%"
   }
}
```

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