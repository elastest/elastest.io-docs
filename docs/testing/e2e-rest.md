<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Running end to end tests (Rest APIs)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

Unit and integration tests are important to verify that isolated and integrated software modules are behaving as expected. Nevertheless, **end to end tests** (sometimes called system tests) are also important, because they allow to test the system as a whole, as seen for the end user. End to end tests are different from unit and integration tests because the [SuT](/#elastest-core-concepts) (Software under Test) is deployed in the same environment as in production.

To execute an end to end test in ElasTest, the SuT have to be declared explicitly. Then, any TJob can be associated to that SuT. In this way, the SuT can be managed independently the number of TJob executed against it.

Here we will run our [JUnit5 Rest Test](https://github.com/elastest/demo-projects/tree/master/rest/junit5-rest-test) provided by default in ElasTest, which makes use of a rest application as a SuT and has a single test that is responsible for making a GET request to that Sut. This test has been developed in Java using [JUnit5](https://junit.org/junit5/):


<div class="row">

<h5 class="small-subtitle">RestAppTest class</h5>
<pre>
<code class="java">
public class RestAppTest extends ElasTestBase {

    @Test
    public void rootServiceTest() {
        String appHost = System.getenv("ET_SUT_HOST");

        if (appHost == null) {
            appHost = "localhost";
        }

        RestTemplate client = new RestTemplate();
        String url = "http://" + appHost + ":8080/";
        logger.info("Send GET request to {}", url);
        String result = client.getForObject(url, String.class);

        assertThat(result).isEqualTo("Hello World!");
    }

}
</code>

</pre>
<blockquote><strong><code>ET_SUT_HOST</code></strong> variable will be the IP of our SuT. ElasTest will automatically inject the right value (Know more about <a href="/docs/testing/environment-variables/">Environment Variables</a>)</blockquote>
</div>

In addition, as can be seen in the example, this test class extends a class called ElasTestBase which is responsible for printing logs at the beginning and end of each test. These two logs have a specific structure and are used by ElasTest to filter the logs corresponding to each test. We explain this in more detail <a href="/docs/testing/unit#xmlAndtestResultsPath">here</a>.

<div id="elastestBaseCode" class="row">
<h5 class="small-subtitle">ElasTestBase class</h5>
<pre>
<code class="java">
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
</code>

</pre>
</div>

<!-- ******************* -->
<!-- ******* RUN ******* -->
<!-- ******************* -->

<h4 class="holder-subtitle link-top">Running the "JUnit5 Rest Test" TJob</h4>

To Run "JUnit5 Rest Test" TJob you only need follow these steps:

<h5 class="small-subtitle">1. Access your ElasTest dashboard</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/dashboard.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/dashboard.png"/></a>
</div>

<h5 class="small-subtitle">2. Get into "Rest API" project</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/project_selection.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/project_selection.png"/></a>
</div>

<h5 class="small-subtitle">3. Run the 'JUnit5 Rest Test' TJob</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/run_tjob.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/run_tjob.png"/></a>
</div>

<h5 class="small-subtitle">4. Execution screen is open automatically</h5>

<p>Our TJob will start running: you will see the test information and log.</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/execution_running.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/execution_running.png"/></a>
</div>

<p>Once the test is finished you will see the test results and log. Eventually the test should end succesfully.</p>

<p>
    <div class="range range-xs range-xs-center warning-range">
        <div class="cell-xs-2 cell-lg-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
        <div class="cell-xs-10 cell-lg-11 warning-text"><p><i>IMPORTANT: ElasTest make use of  <a href="/docs/testing/unit#xmlAndtestResultsPath" title="View XML Report explanation">xml results file</a> to get all the test results information.</i></p></div>
    </div>
</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/execution_finished.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/execution_finished.png"/></a>
</div>

You can click on the Test Suite to display it and see each of the Test Cases. You can also click on one of them to navigate to the information section of this Test Case, where you can see their logs filtered thanks to the two traces of logs that the class ElasTestBase prints at the beginning and end of each test and that we have commented above. There's only one in this TJob, so we'll navigate to this one (rootServiceTest):

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/test_case_result.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/test_case_result.png"/></a>
</div>

You can click too on the **`View In LogAnalyzer`** button for navigate to <a href="/docs/log-analyzer/">Log Analyzer</a> Tool and view the execution logs:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/view_in_loganalyzer.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/view_in_loganalyzer.png"/></a>
</div>

Or you can click on the **`View Case In LogAnalyzer`** button view the specific test execution logs:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/view_case_in_loganalyzer.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/view_case_in_loganalyzer.png"/></a>
</div>

<!-- ****************************** -->
<!-- *** CREATING TJOB YOURSELF *** -->
<!-- ****************************** -->

<h4 class="holder-subtitle link-top">Creating a "JUnit5 Rest Test" TJob yourself</h4>
If you want to create the TJob yourself, you only need follow these steps:

<h5 class="small-subtitle">1. Access your ElasTest dashboard</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/dashboard.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/dashboard.png"/></a>
</div>

<h5 class="small-subtitle">2. Create a New Project</h5>
The Projects serve to organize the TJobs related to each other. You can create a new Project by clicking on the button with the same name. You only need to indicate the name of the project and then click on SAVE button:
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/new_project.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/new_project.png"/></a>
</div>

Immediately you will be redirected to the project page:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/project_page.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/project_page.png"/></a>
</div>

<h5 class="small-subtitle">3. Create a SuT</h5>
There are several ways to deploy a Sut in ElasTest, but they can be grouped in two ways:

-   **`Deployed by Elastest`**: your software is packaged as Docker container/s. It can be a single Docker image or a docker-compose.
    -   **With Commands Container**: Your SuT is packaged as a Docker image. You must write the _Commands Container Image_ and the commands that will run like the docker image CMD.
    -   **With Docker Image**: Your SuT is packaged as a Docker image. ElasTest will pull it from DockerHub and run it as the `Dockerfile` states.
    -   **With Docker Compose**: Your SuT is declared as a docker-compose. ElasTest will pull all the necessary images from DockerHub and run them as the field `Docker Compose`.
-   **`Deployed outside ElasTest`**:  your software is already deployed somewhere.
    -   **No instrumentation**: No monitoring traces sent to ElasTest.
    -   **Instrumented by ElasTest**:  Elastest will be responsible for accessing your Sut to send monitoring traces.
    -   **Manual Instrumentation**: If you want to manually send its logs and metrics to ElasTest.
    -   **Use External Elasticsearch**: if you use your own [Elasticsearch](https://www.elastic.co/guide/index.html) to save the monitoring traces and you want ElasTest to access it to retrieve them.


You can read [Software under Test](/testing/sut) for more detailed information about Sut.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/new_sut_btn.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/new_sut_btn.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/new_sut_page.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/new_sut_page.png"/></a>
</div>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/new_sut_btn.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/new_sut_btn.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/new_sut_page.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/new_sut_page.png"/></a>
</div>

In our case, we will need to insert the following data for create the SuT of "JUnit5 Rest Test" TJob:

-   **SuT Name**: can be called as you want, but we will call it **`Rest App`**
-   **With Commands Container** / **With Docker Image** / **With Docker Compose**: **`With Docker Image`**
-   **Docker Image**: image of the SuT (**`elastest/demo-rest-java-test-sut`**)
-   **Wait for http port**: which port of the SuT should ElasTest wait to be available before starting the TJob (**`8080`**)

<br>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/sut_creation.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/sut_creation.png"/></a>
</div>

<h5 class="small-subtitle">4. Create a new TJob</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/new_tjob_btn.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/new_tjob_btn.png"/></a>
</div>
When a TJob is created, the minimum information that you have to provide is the following:

-   **TJob Name**: name of the TJob
-   **Select a SuT**: If your TJob make use of a Software under Test. In this case, none.
-   **Environment docker image**: the docker image that will host your test. This docker images should contain a client to download your code from your repository hosting service. For example, if your tests are hosted in GitHub and implemented in a Maven project with Java, you need to include a git client, Maven and the Java Development Kit (JDK) in the image.
    <!-- Modify when all images are available for testing with different hostsing services and technologies: Java, Maven, Pyhton, Ruby, Node... -->
-   **Commands**: these are the bash commands to be executed to download the code from a repository and to execute the tests. The specific commands depends on the source code repository type and the technology.

In our case, we will need to insert the following data for the TJob "JUnit5 Rest Test":

-   **TJob Name**: can be called as you want, but we will call it **`JUnit5 Rest Test`**
-   **Test Results Path**: **`/demo-projects/rest/junit5-rest-test/target/surefire-reports`**. This is the complete path where the xml reports of the execution in the container will be saved. We explain this in more detail <a href="/docs/testing/unit#xmlAndtestResultsPath">here</a>.

*   **Select a SuT**: already created SuT to be tested through to the TJob (**`Rest App`**)

-   **Environment docker image**: [`elastest/test-etm-alpinegitjava`](https://github.com/elastest/elastest-torm/blob/master/docker/services/examples/test-etm-alpinegitjava/Dockerfile) (image that contains Git, Maven and Java).
-   **Commands**:

        git clone https://github.com/elastest/demo-projects;
        cd /demo-projects/rest/junit5-rest-test;
        mvn -B test;

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/new_tjob_creation.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/new_tjob_creation.png"/></a>
</div>

By clicking on SAVE the TJob will be saved and you will be redirected to the project page again, where you will be able to execute the TJob.

<h5 class="small-subtitle">5. Run the TJob from the Project's page</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/rest/project_page_with_tjob.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/project_page_with_tjob.png"/></a>
</div>

In this example, when the TJob is executed, the following steps are performed:

1. SuT is executed starting the docker container **`elastest/demo-rest-java-test-sut`**
2. ElasTest waits until container has a http service available in port **`8080`**
3. When service is ready, the test container [`elastest/test-etm-alpinegitjava`](https://github.com/elastest/elastest-torm/blob/master/docker/services/examples/test-etm-alpinegitjava/Dockerfile) is started and specified commands are executed on it.
4. The test implemented in **`/demo-projects/rest/junit5-rest-test`** maven project is executed. This test makes a http request to a Rest endpoint in the SuT and verifies that current result is the expected one.
5. When the test container finishes, ElasTest stops the SuT and TJob containers.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-5" href="/docs/testing/images/rest/e2e-rest-flow.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/rest/e2e-rest-flow.png"/></a>
</div>

<!-- ********************************** -->
<!-- ********* Other Examples ********* -->
<!-- ********************************** -->

<h4 class="holder-subtitle link-top" id="moreExamples">More examples</h4>
The following examples, also offered by default in ElasTest, are implemented with different technologies:

<div class="badges-menu">
    <span id="junit4-btn" class="badge badge-default my-badge selected">Java JUnit4</span>
    <span id="python-btn" class="badge badge-default my-badge my-badge-disabled">Python</span>
    <span id="jasmine-btn" class="badge badge-default my-badge my-badge-disabled">JS Jasmine</span>
    <span id="karate-btn" class="badge badge-default my-badge my-badge-disabled">Java Karate</span>

</div>

<!-- JUNIT4 -->
<div id="junit4" class="testExample badge-tutorial">
You can view the <a target="_blank" href="https://github.com/elastest/demo-projects/tree/master/rest/junit4-rest-test">Source Code in GitHub</a>.
This test has been developed in Java using <a target="_blank" href="https://junit.org/junit4/">JUnit4</a>.

<div class="row">
<h5 class="small-subtitle">RestAppTest class</h5>
<pre>
<code class="java">
public class RestAppTest extends ElasTestBase {

    @Test
    public void rootServiceTest() {
        String appHost = System.getenv("ET_SUT_HOST");

        if (appHost == null) {
            appHost = "localhost";
        }

        RestTemplate client = new RestTemplate();
        String url = "http://" + appHost + ":8080/";
        logger.info("Send GET request to {}", url);
        String result = client.getForObject(url, String.class);

        assertEquals("Hello World!", result);
    }

}
</code>

</pre>
</div>

<div class="row">
<h5 class="small-subtitle">ElasTestBase class</h5>
<pre>
<code class="java">
public class ElasTestBase {

    protected static final Logger logger = LoggerFactory.getLogger(ElasTestBase.class);

    @Rule
    public TestName name = new TestName();

    @Before
    public void logStart() {
        logger.info("##### Start test: " + name.getMethodName());
    }

    @After
    public void logEnd() {
        logger.info("##### Finish test: " + name.getMethodName());
    }

}
</code>
</pre>
</div>

<h5 class="small-subtitle">TJob Configuration</h5>

<ul>
<li><strong>TJob Name</strong>: can be called as you want, but we will call it <strong><code>JUnit4 Rest Test</code></strong></li>
<li><strong>Test Results Path</strong>: <strong><code>/demo-projects/rest/junit4-rest-test/target/surefire-reports</code></strong></li>
<li><strong>Select a SuT</strong>: <strong><code>Rest App</code></strong></li>
<li><strong>Environment docker image</strong>: <a href="https://github.com/elastest/elastest-torm/blob/master/docker/services/examples/test-etm-alpinegitjava/Dockerfile"><code>elastest/test-etm-alpinegitjava</code></a></li>
<li><strong>Commands</strong>: 
<pre>
    <code>
    git clone https://github.com/elastest/demo-projects;
    cd /demo-projects/rest/junit4-rest-test;
    mvn -B test;
    </code>
</pre>
</li>
</ul>

</div>

<!-- PYTHON -->
<div id="python" class="testExample badge-tutorial">
You can view the <a target="_blank" href="https://github.com/elastest/demo-projects/tree/master/rest/python-rest-test">Source Code in GitHub</a>.
This test has been developed in <a target="_blank" href="https://www.python.org/">Python</a>.

<div class="row">
<h5 class="small-subtitle">TestRest class</h5>
<pre>
<code class="python">

import unittest
import os
import sys
import xmlrunner
import ElasTestBase
import requests


class TestRest(ElasTestBase.ElasTestBase):
    def test_root_service(self):
        sutUrl = ElasTestBase.sutUrl
        print 'Send GET request to ' + sutUrl
        response = requests.get(sutUrl)
        self.assertEqual(response.content, 'Hello World!')


if __name__ == '__main__':
    file_path = './testresults'
    if not os.path.exists(file_path):
        os.makedirs(file_path)
    file_name = file_path + '/results.xml'
    with open(file_name, 'wb') as output:
        unittest.main(
            testRunner=xmlrunner.XMLTestRunner(output=output),
            failfast=False, buffer=False, catchbreak=False)

</code>
</pre>
</div>

<div class="row">
<h5 class="small-subtitle">ElasTestBase class</h5>
<pre>
<code class="python">
import unittest
import os

sutUrl = None
class ElasTestBase(unittest.TestCase):
    def setUp(self):
        global sutUrl
        testName = self._testMethodName
        print '##### Start test: ' + testName
        sutIp = '172.17.0.3'
        if('ET_SUT_HOST' in os.environ):
            sutIp = os.environ['ET_SUT_HOST']

        sutUrl = 'http://' + sutIp + ':8080'

    def tearDown(self):
        testName = self._testMethodName
        print '##### Finish test: ' + testName
</code>
</pre>
</div>

<h5 class="small-subtitle">TJob Configuration</h5>

<ul>
<li><strong>TJob Name</strong>: can be called as you want, but we will call it <strong><code>Python Rest Test</code></strong></li>
<li><strong>Test Results Path</strong>: <strong><code>/demo-projects/rest/python-rest-test/testresults</code></strong></li>
<li><strong>Select a SuT</strong>: <strong><code>Rest App</code></strong></li>
<li><strong>Environment docker image</strong>: <a href="https://github.com/elastest/elastest-torm/blob/master/docker/services/examples/test-etm-alpinegitpython/Dockerfile"><code>elastest/test-etm-alpinegitpython</code></a></li> (Alpine image with Git and Python)
<li><strong>Commands</strong>: 
<pre>
    <code>
    git clone https://github.com/elastest/demo-projects;
    cd /demo-projects/rest/python-rest-test;
    python RestTest.py;
    </code>
</pre>
</li>
</ul>
</div>

<!-- JASMINE -->
<div id="jasmine" class="testExample badge-tutorial">
You can view the <a target="_blank" href="https://github.com/elastest/demo-projects/tree/master/rest/jasmine-rest-test">Source Code in GitHub</a>.
This test has been developed in Javascript using <a target="_blank" href="https://jasmine.github.io/">Jasmine</a>.

<div class="row">
<h5 class="small-subtitle">rest-test-spec.js</h5>
<pre>
<code class="javascript">
var request = require('request');
config = require('./elastest-conf.js');

describe('Rest Test', function() {
    it('Root Service Test', function(done) {
        console.log('Send GET request to ' + config.sutUrl);

        request.get(config.sutUrl, function(error, response, body) {
            expect(body).toEqual('Hello World!');
            done();
        });
    });
});

</code>
</pre>
</div>

<div class="row">
<h5 class="small-subtitle">elastest-conf.js</h5>
<pre>
<code class="javascript">
var jasmineReporters = require('jasmine-reporters');
jasmine.getEnv().addReporter(
    new jasmineReporters.JUnitXmlReporter({
        consolidateAll: true,
        savePath: 'testresults',
        // this will produce distinct xml files for each capability
        filePrefix: 'xml-report',
    }),
);

var reporterCurrentSpec = {
    specStarted: function(result) {
        console.log('##### Start test: ' + result.description);
    },
    specDone: function(result) {
        console.log('##### Finish test: ' + result.description);
    },
};

jasmine.getEnv().addReporter(reporterCurrentSpec);

module.exports = {
    sutUrl: process.env.ET_SUT_HOST ? 'http://' + process.env.ET_SUT_HOST + ':8080' : 'http://172.17.0.3:8080',
};

</code>
</pre>
</div>

<h5 class="small-subtitle">TJob Configuration</h5>

<ul>
<li><strong>TJob Name</strong>: can be called as you want, but we will call it <strong><code>Jasmine Rest Test</code></strong></li>
<li><strong>Test Results Path</strong>: <strong><code>/demo-projects/rest/jasmine-rest-test/testresults</code></strong></li>
<li><strong>Select a SuT</strong>: <strong><code>Rest App</code></strong></li>
<li><strong>Environment docker image</strong>:  <a href="https://github.com/elastest/elastest-torm/blob/master/docker/services/examples/test-etm-alpinegitnode/Dockerfile"><code>elastest/test-etm-alpinegitnode</code></a></li> (Alpine image with Git, Node, and necessary libraries like jasmine)
<li><strong>Commands</strong>: 
<pre>
    <code>
    npm install --save request;
    git clone https://github.com/elastest/demo-projects;
    cd /demo-projects/rest/jasmine-rest-test;
    jasmine;
    </code>
</pre>
</li>
</ul>
</div>

<!-- KARATE -->
<div id="karate" class="testExample badge-tutorial">
You can view the <a target="_blank" href="https://github.com/elastest/demo-projects/tree/master/rest/karate-rest-test">Source Code in GitHub</a>.
This test has been developed in Java using <a target="_blank" href="https://github.com/intuit/karate">Karate</a> .

<div class="row">
<h5 class="small-subtitle">root-service-test.feature</h5>
<pre>
<code class="java">
Feature: Test a Sut 

Scenario: Navigate to url and obtain 200 response 
    Given  url appUrl 
    When   method get 
    Then   status 200 
Scenario: Navigate to url and obtain 500 response 
    Given  url appUrl 
    When   method get 
    Then   status 500 
</code>

</pre>
</div>

<div class="row">
<h5 class="small-subtitle">RestAppTest class</h5>
<pre>
<code class="java">
@RunWith(Karate.class)
public class RestAppTest {
}
</code>

</pre>
</div>

<div class="row">
<h5 class="small-subtitle">karate-config.js</h5>
<pre>
<code class="javascript">
function() {   

  // Log start and finish every scenario
  karate.log('##### Start test:',karate.info.scenarioName);
  karate.configure("afterScenario",function(){
      karate.log('##### Finish test:',karate.info.scenarioName);
  });
  
  var host = java.lang.System.getenv('ET_SUT_HOST');
  if(!host) {
	  host = "localhost"
  }
  var url = "http://" + host + ":8080";
  var config = {
    appUrl: url
  };
  
  return config;
}
</code>
</pre>
</div>

<h5 class="small-subtitle">TJob Configuration</h5>

<ul>
<li><strong>TJob Name</strong>: can be called as you want, but we will call it <strong><code>Karate Rest Test</code></strong></li>
<li><strong>Test Results Path</strong>: <strong><code>/demo-projects/rest/karate-rest-test/target/surefire-reports</code></strong></li>
<li><strong>Select a SuT</strong>: <strong><code>Rest App</code></strong></li>
<li><strong>Environment docker image</strong>:  <a href="https://github.com/elastest/elastest-torm/blob/master/docker/services/examples/test-etm-alpinegitjava/Dockerfile"><code>elastest/test-etm-alpinegitjava</code></a></li>
<li><strong>Commands</strong>: 
<pre>
    <code>
    git clone https://github.com/elastest/demo-projects;
    cd /demo-projects/rest/karate-rest-test;
    mvn -B test;
    </code>
</pre>
</li>
</ul>
</div>

<!-- ********************* -->
<!-- ****** Scripts ****** -->
<!-- ********************* -->
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
    loop: false,
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

<script>
$('#junit4-btn').click(function(event) {
  activateBadge('junit4');
});
$('#karate-btn').click(function(event) {
  activateBadge('karate');
});
$('#python-btn').click(function(event) {
  activateBadge('python');
});
$('#jasmine-btn').click(function(event) {
  activateBadge('jasmine');
});

function activateBadge(sectionName) {
  var disabledClass = 'my-badge-disabled';
  var selectedClass = 'selected';
  
  $('.testExample').hide();
  $('#' + sectionName).show();
  
  // Disable current selected
  $('.selected').addClass(disabledClass);
  $('.selected').removeClass(selectedClass);
  
  // Select clicked
  $('#' + sectionName + '-btn').addClass(selectedClass);
  $('#' + sectionName + '-btn').removeClass(disabledClass);
}

window.onload = function() {
      activateBadge('junit4');
}
</script>
