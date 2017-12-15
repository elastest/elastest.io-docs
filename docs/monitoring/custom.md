<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Custom monitoring</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h4 id="custom-monitoring-from-sut" class="holder-subtitle link-top">Custom monitoring from SuT</h4>

You maybe want your Dockerized SuT to send custom metrics to ElasTest appart from those automatically retrieved by our standard monitoring agents. In that case, all techniques used to instrument manually an already deployed SuT can be used in a SuT deployed by ElasTest. Check [Deployed monitoring](../../docs/monitoring/deployed) section.

<h4 class="holder-subtitle link-top">Custom monitoring from tests</h4>

It can be useful to graph some custom information generated in the tests alongside with other metrics. You maybe want to graph some variables of your test, whatever they are. 

For example: if your SuT is a web application, your test can send the number of users connecting to it as it executes and you can compare it with the CPU consumption or memory usage of the SuT. For this reason, testers can send to ElasTest any monitoring information they want.

When a TJob is executed, the following environment variables are injected so you can use them in your test code:

- *`ET_MON_LSHTTP_API`*: Logstash API URL to send http requests with monitoring information.  
- *`ET_MON_EXEC`*: The execution identifier to set the value of `exec` field. 

The allowed formats are the same as described for Deployed SuT in [Send metrics with HTTP](../../docs/monitoring/deployed#send-metrics-with-http), but with the following considerations: 

- Field **exec** must have the value of environment variable `ET_MON_EXEC`.
- Field **component** must contain the value `test`, because the event is generated in the test.
- The URL of the POST request must be the value of environment variable `ET_MON_LSHTTP_API`

With these changes, the body of a POST request sending a custom metric with the number of concurrent users would be

```json
{
   "@timestamp": 9999999999,
   "exec": "XX",
   "component": "test",
   "type": "users",
   "stream_type": "atomic_metric",
   "users": 80,
   "unit": "users"
}
```

"users" can be customized as you want.

<!--<h4 class="holder-subtitle link-top">Custom monitoring from TSS</h4>

Some of the key drivers of ElasTest development is to make life easier to testers. For this reason, [Test Support Services](/#tss) can send custom metrics to ElasTest. For example, when a test is making use of Web Browsers service, the browser console is sent to ElasTest and can be visualized alongside SuT and Test logs.

For every TSS used on a TJob execution, the tester will be able to select all the desired metrics to be shown from a predefined set (different for each TSS).-->
