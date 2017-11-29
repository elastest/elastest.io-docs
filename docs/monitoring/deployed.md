<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Deployed monitoring</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

When ElasTest is executing tests against an already deployed [SuT](../../docs#elastest-core-concepts), it is necessary to explicitly gather monitoring information from it if we want to benefit from ElasTest monitoring and analysis features. The required instrumentation can be done in two different ways:

 - **Automated instrumentation**: If the SuT is a linux box with ssh access, ElasTest will be able to instrument it automatically. ***(Feature coming soon)***
 - **Manual instrumentation**: The SuT admin may install itself the instrumentation agents or configure the platform to send monitoring information to ElasTest.



<h4 class="holder-subtitle">Manual instrumentation</h4>

Manual instrumentation can be done by:

- **Using Beats technology: [Beats](https://www.elastic.co/products/beats)** is a platform for single-purpose data shippers created to work with Logstash and ElasticSearch. There are a lot of beats agents to collect monitoring information from all kinds of sources. For example: [Filebeat](https://www.elastic.co/products/beats/filebeat), [Metricbeat](https://www.elastic.co/products/beats/metricbeat) or [Packetbeat](https://www.elastic.co/products/beats/packetbeat). If you can't find a certain beat agent among the official ones, you can always search [beats bult by the community](https://www.elastic.co/guide/en/beats/libbeat/current/community-beats.html) or [create your own beat](https://www.elastic.co/guide/en/beats/devguide/current/new-beat.html).

- **Sending metrics with http POST requests**: If beats agents doesn’t suit your needs, you can always send monitoring information with http requests. ***(Feature coming soon)***

To create a SuT ready to be manually instrumented, fill the form as shown in the image below on "New SuT" page:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/monitoring/images/new_SuT_manual_instrumentation_1.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/new_SuT_manual_instrumentation_1.png"/></a>
</div>

Once you click on _Save and get monitoring details_  button, the following configuration parameters will be shown:

- **Logstash IP**: The public host (IP or FQDN) in which Logstash is located.
- **Logstash Beats Port**: The port in which Logstash can receive beats monitoring information.
- **HTTP port**: The port in which Logstash listens for http requests with monitoring information.
- **Exec ID**: The execution identification value that has to be included in events sent to Logstash. This value is used to identify what events belongs to this SuT.

We will be using them in the following section.

<div class="docs-gallery more-margin-top inline-block">
    <a data-fancybox="gallery-2" href="/docs/monitoring/images/new_SuT_manual_instrumentation_2.png"><img class="img-responsive img-wellcome" src="/docs/monitoring/images/new_SuT_manual_instrumentation_2.png"/></a>
</div>

<h4 id="send-metrics-with-beats" class="holder-subtitle link-top">Send metrics with Beats</h4>

As ElasTest already includes the required packages for using Beats ([Logstash](https://www.elastic.co/products/logstash) and [ElasticSearch](https://www.elastic.co/products/elasticsearch)), you will only have to follow the [official documentation](https://www.elastic.co/guide/en/beats/libbeat/current/installing-beats.html) for installing and configuring beat agents inside your deployed SuT.

To illustrate this process, let's see a pretty common use case: you have an app deployed somewhere in the cloud, and you want to run a TJob in ElasTest to test some feature of it.

<h6 style="color: #666666">1. Create a new SuT</h6>

First of all, create a new SuT inside any Project in your ElasTest dashboard. Do it with **Deployed SuT** and **Instrumented by SuT Admin** options, just as shown in the images above.

<h6 style="color: #666666">2. Install Filebeat on your SuT machine</h6>

Let's suppose we have an Ubuntu machine hosting our app. We connect to it through _ssh_ and run the command that [Step 1 of Filebeat documentation](https://www.elastic.co/guide/en/beats/filebeat/6.0/filebeat-installation.html) tells us. In this case, by using Debian packages:

```bash
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.0.0-amd64.deb
sudo dpkg -i filebeat-6.0.0-amd64.deb
```

<h6 style="color: #666666">3. Configure Filebeat agent to suit your needs</h6>

Take a look to [Step 2 of Filebeat documentation](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-configuration.html). The predefined default value for Filebeat is to gather all logs inside "/var/log/" folder:

```yml
filebeat.prospectors:
- type: log
  enabled: true
  paths:
    - /var/log/*.log
```

<h6 style="color: #666666">4. Configure Filebeat agent to connect to ElasTest</h6>

Again, just need to take a quick look to [Step 3 of Filebeat documentation](https://www.elastic.co/guide/en/beats/filebeat/current/config-filebeat-logstash.html).

Our brand new agent has to be configured to send information to the Logstash instance of ElasTest. Logstash Host and beats port have to be used in Filebeat configuration file (in our machine that is `/etc/filebeat/filebeat.yml`):

```yml
#----------------------------- Logstash output --------------------------------
output.logstash:
  hosts: ["127.0.0.1:5044"]
```

Where **127.0.0.1** has to be changed to the value of **Logstash IP** and **5044** to the value of **Logstash Beats Port**. To include the **Exec ID** value, it is necessary to add custom fields in config file. Those fields are:

```yml
fields_under_root: true
fields:
  exec: XX
  component: YY
  stream: ZZ
```

The value of the fields are:

- **exec**: The value of **Exec ID** shown in ElasTest dashboard when SuT is created.
- **component**: The name of the component in which this log is generated. For example: `sut`, `sut-webapp`, `sut-bbdd`. It is recommended that this name starts with "sut-" to allow to group SuT components in ElasTest.
- **stream**: The name of the event stream. If the stream is a log and this is the only log for the component, it is recommended to call it `default_log`. 

<h4 id="send-metrics-with-http" class="holder-subtitle link-top">Send metrics with HTTP</h4>

If it is not possible to use beats agents, you can always send SuT metric information with http requests. The URL is created with **Logstash IP** and **HTTP port** params:

```text
http://<logstash_host>:<http_port>/
```

The request has to use the POST method. There are different formats to send different types of information:

<h6 class="small-subtitle">Send one log entry in one request</h6>

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
- **exec**: The value of **Exec ID** shown in ElasTest dashboard when SuT is created.
- **component**: identified the component that sends the metric. For example, if there is only a SuT app without any other service, it can be "sut". But if the SuT is a web application with database, it is good idea to have "sut_webapp" and "sut_ddbb" for logs of that two services. Note: use underscore like separator. Dash (-) is not allowed.
- **stream**: Used to distinguish several logs from the same component. In this case only one log exists for the component, its value is usually "default_log".
- **message**: Complete log message entry.

<h6 class="small-subtitle">Send several log entries in one request</h6>

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

<h6 class="small-subtitle">Send one atomic metric in one request</h6>

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

<h6 class="small-subtitle">Send one composed metric in one request</h6>

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
