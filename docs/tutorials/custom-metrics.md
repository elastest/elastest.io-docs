<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Custom metrics</h2>
<div class="offset-top-30 offset-md-top-30">
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
   "et_type": "cpu",
   "stream_type": "composed_metric",
   "cpu": {
     "total_usage": 80,
     "max_usage": 100
   },
   "units": {
     "total_usage": "%",
     "max_usage": "%"
   }
}
```

<h4 id="send-metrics-with-http" class="holder-subtitle link-top">Creating a TJob with metrics recollection</h4>

<h5 class="small-subtitle">Test <i class="fab fa-java"></i></h5>

```java
public class CustomMetrics extends ElasTestBase {

	protected static final Logger logger = getLogger(lookup().lookupClass());

	protected static String urlLogstash;
	protected static String execId;
	protected static String containerName;
	protected static String counterStr;
	protected static OperatingSystemMXBean osBean;
	protected static boolean credentials = false;
	protected static String username;
	protected static String password;

	@BeforeAll
	public static void setupClass() {
		osBean = ManagementFactory.getPlatformMXBean(OperatingSystemMXBean.class);

		counterStr = System.getenv("COUNTER");
		urlLogstash = System.getenv("ET_MON_LSHTTP_API");
		execId = System.getenv("ET_MON_EXEC");
		username = System.getenv("CREDENTIALS_NAME");
		password = System.getenv("CREDENTIALS_PASS");

		if (username != null && password != null) {
			credentials = true;
			logger.info("Logstash with credentials");
		} else {
			logger.info("Logstash without credentials");
		}

		if (counterStr == null) {
			counterStr = "10";
		}

		logger.info("\n-Logstash Ip: " + urlLogstash + "\n-Execution Identifier: " + execId + "\n-Generate "
				+ counterStr + " prime numbers");
	}

	@Test
	public void test() {
		int counter = Integer.parseInt(counterStr);

		while (counter >= 0) {
			BigInteger prime = BigInteger.probablePrime(1024, new Random()); // Stress CPU

			logger.info("Generate prime number: " + prime.toString());

			double javaCpu = osBean.getProcessCpuLoad() * 100;
			double totalCpu = osBean.getSystemCpuLoad() * 100;

			try {
				sendPostToLogstash(generateMetric("component1", "use_cpu", javaCpu, "Java_usage_CPU", "%", totalCpu,
						"Total_usage_CPU", "%"));
			} catch (Exception e) {
				logger.info("Error when send information to logstash");
				e.printStackTrace();
			}

			sleep(5000);
			counter--;
		}
	}

	public String generateMetric(String component, String stream, double v1, String s1, String u1, double v2, String s2,
			String u2) {
		String trace = "{" + "\"" + s1 + "\": " + v1 + "," + "\"" + s2 + "\": " + v2 + "" + "}";

		String units = "{" + "\"" + s1 + "\":\"" + u1 + "\"," + "\"" + s2 + "\":\"" + u2 + "\"" + "}";

		String body = "{" + "\"et_type\":\"composed_example\"" + ",\"component\":\"" + component + "\"" + ",\"exec\":\""
				+ execId + "\"" + ",\"stream\":\"custom_metric\"" + ",\"stream_type\":\"composed_metrics\""
				+ ",\"composed_example\": " + trace + ",\"units\": " + units + "}";

		return body;
	}

	public void sendPostToLogstash(String body) throws Exception {
		URL url = new URL(urlLogstash);

		URLConnection con = url.openConnection();
		HttpURLConnection http = (HttpURLConnection) con;
		http.setRequestMethod("POST");
		http.setDoOutput(true);

		byte[] out = body.getBytes(StandardCharsets.UTF_8);

		int length = out.length;

		http.setFixedLengthStreamingMode(length);
		http.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

		if (credentials) {
			String encoded = Base64.getEncoder()
					.encodeToString((username + ":" + password).getBytes(StandardCharsets.UTF_8));
			
			http.setRequestProperty("Authorization", "Basic " + encoded);
		}
		
		http.connect();

		OutputStream os = http.getOutputStream();
		os.write(out);
		os.close();
	}

	private void sleep(int time) {
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

}
```

This test stress the machine generating prime numbers and recollect the CPU usage by Java and the System for send it to ElasTest. Now we will launch this test using Jenkins in ElasTest.

<h5 class="small-subtitle">Jenkins <i class="fab fa-jenkins"></i></h5>

```groovy
node{
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', project: 'Jenkins Examples') {
        stage ('Executing Test') {
            echo 'Print env variables'
            sh 'env'
            echo 'Set up test environment'
            mvnHome = tool 'M3.3.9'
            echo 'Cloning repository'
            git 'https://github.com/elastest/demo-projects'
            echo 'Run test'
            sh "cd ./custommetrics-test; '${mvnHome}/bin/mvn' -Dtest=CustomMetrics -B test"
            step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
        
        }        
    }
}
```

If you ElasTest with credential use the env variables when run the test:

*   **`CREDENTIALS_NAME`**: For the user name.
*   **`CREDENTIALS_PASS`**: For the user password.

For example: 

```groovy
...
sh "cd ./custommetrics-test; export CREDENTIALS_NAME=elastest; CREDENTIALS_PASS=elastest; '${mvnHome}/bin/mvn' -Dtest=CustomMetrics -B test"
...
```

Now go to create **`Pipeline`**, first open the create item, select name **`CustomMetrics`** and mark the **`Pipeline`** option:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/custom-metrics/new-item.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/custom-metrics/new-item.png"/></a>
</div>

In this page you paste the previos **`Pipeline`**:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/custom-metrics/create-pipeline.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/custom-metrics/create-pipeline.png"/></a>
</div>

When the Job is created, your select the **`Build Now`**:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/custom-metrics/run-job.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/custom-metrics/run-job.png"/></a>
</div>

After the execution is finished. You see the TJob in ElasTest, now you click in the **`Settings`** button like show in the following image:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/custom-metrics/result-TJob.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/custom-metrics/result-TJob.png"/></a>
</div>

Now you select the metrics that you like see and click in the **`Apply and Save`**:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/custom-metrics/select-metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/custom-metrics/select-metrics.png"/></a>
</div>

The metrics show in the **`TJob Monitoring`** section:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/custom-metrics/show-metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/custom-metrics/show-metrics.png"/></a>
</div>