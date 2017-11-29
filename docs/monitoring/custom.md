<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Custom monitoring</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Custom monitoring from SuT</h4>

In some cases, SuT can send custom metrics to ElasTest that are not retrieved by standard monitoring agents. In that case, all the techniques used to instrument manually an already deployed SuT can be used in a SuT deployed by ElasTest.

<h4 class="holder-subtitle link-top">Custom monitoring from tests</h4>

It can be useful to graph some custom information generated in the tests alongside with other metrics. For example, a test can increase the number of simultaneous requests against the SuT. If the test sends that information to ElasTest, then it can be plotted in the same graph as CPU consumption of the Sut. For this reason, test developer can send to ElasTest any monitoring information he wants.

When a TJob is executed, the following environment variables are injected:

- *`ET_MON_LSHTTP_API`*: Logstash API URL to send http requests with monitoring information.  
- *`ET_MON_EXEC`*: The execution identifier to set the value of `exec` field. 

The allowed formats are the same as described for Deployed SuT in [Deplyed monitoring](../../docs/monitoring/deployed#send-metrics-with-http) section, but with the following considerations: 

- Field **exec** should have the value of environment variable `ET_MON_EXEC`.
- Field **component** should contain the value `test`, because the event is generated in the test.

With these changes, the body of a POST request sending a custom metric with the number of concurrent users will be

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

<h4 class="holder-subtitle link-top">Custom monitoring from TSS</h4>

Some of the key drivers of ElasTest development is to make life easier to testers. For this reason, Test Support Services can send custom metrics to ElasTest. For example, when a test is making use of Web Browsers service, the browser console is sent to ElasTest and can be visualized alongside SuT and Test logs.
