<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">End to End Testing in ElasTest</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h4 class="small-subtitle">Using Jenkins with ElasTest</h4>

For this tutorial we use Jenkins, for view how install the ElasTest plugin in Jenkins or how use the integrated Jenkins in ElasTest please visit the following [link](/tutorials/using-jenkins/).

<h4 class="small-subtitle">Test</h4>

Let's see how launch a TJob that makes use a web browser inside Elastest. Here we will run our [API Test](https://github.com/elastest-experiments/webapp-2/tree/master/AMICOServer/src/test/java/com/example/demo/e2e/api), which makes use of a Spring Boot Application as a SuT the application is a platform for education. Also has one test what check that a user not logged can't access to the sensible information.

First we can see the code of the normal api test. The **`profile_uri`** variable contains the URL of the application that we will atack. 

##### **TestAPIRestTemplateWithoutElasTest**

```java
public class TestAPIRestTemplateWithoutElasTest {

	final static Logger log = getLogger(lookup().lookupClass());

    protected static String profile_uri;

    @BeforeAll
    public static void setupClass() {
        profile_uri = "http://localhost:8000/api/users/{user}";
    }
    
	@Test
	public void checkShowProfile() throws KeyManagementException, NoSuchAlgorithmException, KeyStoreException {
		String url = profile_uri.replace("{user}", "amico");
		RestTemplate restTemplate = new RestTemplate(SSLClientFactory.getClientHttpRequestFactory(HttpClientType.HttpClient));

		HttpStatus status;
		HttpStatus expected = HttpStatus.UNAUTHORIZED;

		try {
			ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
			status = response.getStatusCode();
		} catch (HttpStatusCodeException e) {
			status = e.getStatusCode();
		}

		Assert.assertEquals("failure - expected HTTP status " + expected, expected, status);
		log.info("The response is correct");
	}

}
```

Now we will see the changes we need for adapt the test to ElasTest. First need add the ElasTestBase in the project, which is responsible for printing logs at the beginning and end of each test. These two logs have a specific structure and are used by ElasTest to filter the logs corresponding to each test. We explain this in more detail <a href="/docs/testing/unit#xmlAndtestResultsPath">here</a> 

##### **ElasTestBase**

```java
public class ElasTestBase {

    protected static final Logger logger = LoggerFactory.getLogger(ElasTestBase.class);

    @BeforeEach
    public void logStart(TestInfo testInfo) {
        logger.info("##### Start test: " + testInfo.getTestMethod().get().getName());
    }

    @AfterEach
    public void logEnd(TestInfo testInfo) {
        logger.info("##### Finish test: " + testInfo.getTestMethod().get().getName());
    }

}
```

In the test should extends the class ElasTestBase.

##### **TestAPIRestTemplate**

```java
public class TestAPIRestTemplate extends ElasTestBase{

	final static Logger log = getLogger(lookup().lookupClass());

    protected static String sutUrl;
    protected static String profile_uri;

    @BeforeAll
    public static void setupClass() {
        String sutHost = System.getenv("ET_SUT_HOST");
        String sutPort = System.getenv("ET_SUT_PORT");
        String sutProtocol = System.getenv("ET_SUT_PROTOCOL");

        if (sutHost == null) {
            sutUrl = "http://localhost:8000/";
        } else {
            sutPort = sutPort != null ? sutPort : "8080";
            sutProtocol = sutProtocol != null ? sutProtocol : "http";

            sutUrl = sutProtocol + "://" + sutHost + ":" + sutPort + "/";
        }
        
        profile_uri = sutUrl + "api/users/{user}";
        logger.info("Webapp URL: " + sutUrl);
    }
    
	@Test
	public void checkShowProfile() throws KeyManagementException, NoSuchAlgorithmException, KeyStoreException {
		String url = profile_uri.replace("{user}", "amico");
		RestTemplate restTemplate = new RestTemplate(SSLClientFactory.getClientHttpRequestFactory(HttpClientType.HttpClient));

		HttpStatus status;
		HttpStatus expected = HttpStatus.UNAUTHORIZED;

		try {
			ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
			status = response.getStatusCode();
		} catch (HttpStatusCodeException e) {
			status = e.getStatusCode();
		}

		Assert.assertEquals("failure - expected HTTP status " + expected, expected, status);
		log.info("The response is correct");
	}

}
```

We need added the following variables:

```java
String sutHost = System.getenv("ET_SUT_HOST");
String sutPort = System.getenv("ET_SUT_PORT");
String sutProtocol = System.getenv("ET_SUT_PROTOCOL");
```

This variables we supply information about the **`SUT`**.

>-  **`ET_SUT_HOST`**, **`ET_SUT_PORT`** and **`ET_SUT_PROTOCOL`**  variables will be the IP, port and protocol of our SuT respectively. ElasTest will automatically inject the right value (Know more about <a href="/docs/testing/environment-variables/">Environment Variables</a>)

<h4 class="small-subtitle">Elastest pipeline</h4>

To run our tests using Jenkins in Elastest, first open the Jenkins and click in **`new Item`**

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/jenkins/pipeline/new-item.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/new-item.png"/></a>
</div>

Write the name of the item: **`AMICourses`** and select **`Pipeline`**

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/jenkins/pipeline/item-name.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/item-name.png"/></a>
</div>

##### **Normal Pipeline**

We will see the normal **`Pipeline`** for used this Test in Jenkins.

```groovy
node{   
    stage('Setting environment'){
        git "https://github.com/elastest-experiments/webapp-2.git"
    }
    
    try{
        stage('Start Sut') {
            echo 'Running SUT'
            sh "cd docker-compose; export AMICO_IMAGE=webapp-2-fixed-profile; docker-compose up -d && ./wait-app.sh 8000"
        }
        stage("Run Tests") {   
            echo 'Running test'
            mvnHome = tool 'M3.3.9'
            sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
            step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
        }
    } finally {
        echo 'Stopping SUT'
        sh "cd docker; docker-compose down"
    }
}
```

The example above can be split into the following sections:

<p></p>

-   **Start SUT** : This block started the SUT application. The script **`wait-app.sh`** wait for the **`SUT`** is ready.

<p></p>

```groovy
stage('Start Sut') {
    echo 'Running SUT'
    sh "cd docker-compose; export AMICO_IMAGE=webapp-2-fixed-profile; docker-compose up -d && ./wait-app.sh 8000"
}
```

<p></p>

-   **Run Test** : The tests execute if the SUT working correctly.

<p></p>

```groovy
stage("Run Tests") {   
    echo 'Running test'
    mvnHome = tool 'M3.3.9'
    sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
}
```

<p></p>

-   **Stop SUT** : The SUT will stop when the test is finished.

<p></p>

```groovy
} finally {
    echo 'Stopping SUT'
    sh "cd docker; docker-compose down"
}
```

##### **ElasTest Pipeline**

Now we will see the changes we need for adapt the **`Pipeline`** to ElasTest.

```groovy
node{
    def sutIp
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage("Setting environment") {
            echo 'Environment variables'
            sh "env"
            git "https://github.com/elastest-experiments/webapp-2.git"
        }
        try {
            stage("Start Sut") {
                sh "cd docker-compose; export AMICO_IMAGE=webapp-2-fixed-profile; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
                sutContainerName = env.ET_SUT_CONTAINER_NAME + "_webapp2_1";
                sutNetwork = getFirstNetwork(sutContainerName)
                sutIp = containerIp(sutContainerName,network)

                echo 'Sut ip: '+ sutIp
                sh 'docker run -e IP=' + sutIp + ' -e PORT=8000 --network=' + sutNetwork + ' elastest/etm-check-service-up'
            }
            stage("Run Tests") {
                withEnv(['ET_SUT_HOST=' + sutIp, 'ET_SUT_PORT=8000']) {
                    echo 'Running test'
                    mvnHome = tool 'M3.3.9'
                    sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
                    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                }
            }
        } finally {
                echo 'Stopping SUT'
                sh "cd docker; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
        }
    }
}


def getFirstNetwork(containerName) {
    echo "Inside getFirstNetwork function"
    network = sh (
        script: "docker inspect " + containerName + " -f \"{%raw%}{{json .NetworkSettings.Networks}}{%endraw%}\" | awk \"{sub(/:.*/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/{/,\\\"\\\")}1\"",
        returnStdout: true
    ).trim()
    
    echo containerName+" Network = " + network;
    return network;
}

def containerIp(containerName, network) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{%raw%}{{.NetworkSettings.Networks." + network + ".IPAddress}}{%endraw%}\" "+ containerName,
        returnStdout: true
    ).trim()
    
    echo containerName+" IP = " + containerIp;
    return containerIp;
}
```

The example above can be split into the following sections:

-   **ElasTest plugin block with configuration** : this block will contain all the steps that the test must follow, as well as the necessary [configuration options](#options).

<p></p>

```groovy
node{
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        .......
    }
}
```

<p></p>

-   **Sut configuration** : The SUT must be started, passing the **`${env.ET_SUT_CONTAINER_NAME}`** env variable (provided by ElasTest) as name of the container. This will allow ElasTest to receive logs and metrics from the Sut.

<p></p>

```groovy
sh "cd docker-compose; export AMICO_IMAGE=webapp-2-fixed-profile; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
sutContainerName = env.ET_SUT_CONTAINER_NAME + "_webapp2_1";
sutNetwork = getFirstNetwork(sutContainerName)
sutIp = containerIp(sutContainerName,network)
```

<p></p>

-   **Wait for Sut** : You have to obtain the Sut network and ip and run check image (elastest/etm-check-service-up) provided by ElasTest to wait for the Sut to be ready to be used. This step is not required, you can wait in other ways or not do it, but for this example we do it.

<p></p>

```groovy
echo 'Sut ip: '+ sutIp
sh 'docker run -e IP=' + sutIp + ' -e PORT=8000 --network=' + sutNetwork + ' elastest/etm-check-service-up'
```

We need added the following code in the **`Pipeline`**:

```groovy
def getFirstNetwork(containerName) {
    echo "Inside getFirstNetwork function"
    network = sh (
        script: "docker inspect " + containerName + " -f \"{%raw%}{{json .NetworkSettings.Networks}}{%endraw%}\" | awk \"{sub(/:.*/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/{/,\\\"\\\")}1\"",
        returnStdout: true
    ).trim()
    
    echo containerName+" Network = " + network;
    return network;
}

def containerIp(containerName, network) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{%raw%}{{.NetworkSettings.Networks." + network + ".IPAddress}}{%endraw%}\" "+ containerName,
        returnStdout: true
    ).trim()
    
    echo containerName+" IP = " + containerIp;
    return containerIp;
}
```

This code obtain the network and the ip of the **`SUT`** container this information is needed for wait the **`SUT`** is ready to launch the Tests. It's functions has like the script **`wait-app.sh`** we seen in the normal [Pipeline](#normal-pipeline).

<p></p>

-   **Test Execution** : Finally, the tests should be executed to verify that the SUT is working correctly. Remember that you have to configure the Sut ip as an environment variable or pass it as a maven property so that the test knows where the SUT is.

<p></p>

```groovy
stage("Run Tests") {
    withEnv(['ET_SUT_HOST=' + sutIp, 'ET_SUT_PORT=8000']) {
        echo 'Running test'
        mvnHome = tool 'M3.3.9'
        sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
        step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
    }
}
```

<p></p>

-   **Stop Sut** : The SUT will stop when the test is finished, passing the **`${env.ET_SUT_CONTAINER_NAME}`** env variable (provided by ElasTest) as name of the container.

<p></p>

```groovy
} finally {
        echo 'Stopping SUT'
        sh "cd docker; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
}
```

<p></p>

Copy the **`ElasTest Pipeline`** and paste in the **Pipeline** section, as follows:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/jenkins/pipeline/pipeline.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/pipeline.png"/></a>
</div>

When the Job is created, we will click in **`Build Now`** button:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/jenkins/pipeline/run-tjob.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/run-tjob.png"/></a>
</div>

After pressing the button, you will see the job running on Jenkins:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/jenkins/pipeline/running-tjob.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/running-tjob.png"/></a>
</div>

Entering the build page, you will see the Open in ElasTest button, where you can see the execution page in ElasTest (If the button does not appear refresh the page, it may take a while). ElasTest will have created a project called **`Jenkins Examples`** also you show the project in this section.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/jenkins/pipeline/open-in-elastest.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/open-in-elastest.png"/></a>
</div>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/jenkins/pipeline/execution.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/execution.png"/></a>
</div>

<h4 class="small-subtitle">Collecting logs & metrics automatically</h4>

ElasTest collect logs and metrics automatically this will show in the section **`TJob Monitoring`** of the **`TJob`**. There logs may download if click in the button marked.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/tutorials/images/jenkins/logs/tjob-monitoring.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/tjob-monitoring.png"/></a>
</div>

<h4 class="small-subtitle">Observing sut & test behaviour in elastest</h4>

In the **TJob** we will observe the logs of the sut or test selecting the **sut** or **test** like we show in the following image:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/tutorials/images/jenkins/logs/sut-logs.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/sut-logs.png"/></a>
</div>

<h4 class="small-subtitle">Comparing executions (logs & metrics)</h4>

ElasTest allows compare two different executions, we will may the logs and metric comparative. We relaunch the Jenkins Job, but with a small changed. This changed makes the execution correct. 

Change `export AMICO_IMAGE=webapp-2-fixed-profile;` for `AMICO_IMAGE=webapp-2-master;` in the **`Pipeline`**. The final result show in the folloging box:

```groovy
node{
    def sutIp
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage("Setting environment") {
            echo 'Environment variables'
            sh "env"
            git "https://github.com/elastest-experiments/webapp-2.git"
        }
        try {
            stage("Start Sut") {
                sh "cd docker-compose; export AMICO_IMAGE=webapp-2-master; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
                sutContainerName = env.ET_SUT_CONTAINER_NAME + "_webapp2_1";
                sutNetwork = getFirstNetwork(sutContainerName)
                sutIp = containerIp(sutContainerName,network)

                echo 'Sut ip: '+ sutIp
                sh 'docker run -e IP=' + sutIp + ' -e PORT=8000 --network=' + sutNetwork + ' elastest/etm-check-service-up'
            }
            stage("Run Tests") {
                withEnv(['ET_SUT_HOST=' + sutIp, 'ET_SUT_PORT=8000']) {
                    echo 'Running test'
                    mvnHome = tool 'M3.3.9'
                    sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
                    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                }
            }
        } finally {
                echo 'Stopping SUT'
                sh "cd docker; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
        }
    }
}


def getFirstNetwork(containerName) {
    echo "Inside getFirstNetwork function"
    network = sh (
        script: "docker inspect " + containerName + " -f \"{%raw%}{{json .NetworkSettings.Networks}}{%endraw%}\" | awk \"{sub(/:.*/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/{/,\\\"\\\")}1\"",
        returnStdout: true
    ).trim()
    
    echo containerName+" Network = " + network;
    return network;
}

def containerIp(containerName, network) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{%raw%}{{.NetworkSettings.Networks." + network + ".IPAddress}}{%endraw%}\" "+ containerName,
        returnStdout: true
    ).trim()
    
    echo containerName+" IP = " + containerIp;
    return containerIp;
}
```

When we changed it, we will relaunch the job. And we will see:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-5" href="/docs/tutorials/images/jenkins/logs/jenkis-job.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/jenkis-job.png"/></a>
</div>

Now we will go to the **`AMICourses`** TJob in elastest and select the two executions from the table and finally press the **Compare Executions** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-5" href="/docs/tutorials/images/jenkins/logs/select-tjobs-for-comparing.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/select-tjobs-for-comparing.png"/></a>
</div>

Once added you will see the following card, in this card we will see the metric comparisons and we will select the **test_default_log** and click the **Start Comparison** button for the show the comparison logs.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-5" href="/docs/tutorials/images/jenkins/logs/compare-metrics-select-comparison.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/compare-metrics-select-comparison.png"/></a>
</div>

When push the button we will show the comparative betwen the two executions. In this case we will check that the left log return a 401 error nevertheless the right log return some information in JSON format. The test check that the not logged person no see the information that not correspond them. Therefore we check that the error is because the application return sensible information when not logged user.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-5" href="/docs/tutorials/images/jenkins/logs/compare-error.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/compare-error.png"/></a>
</div>