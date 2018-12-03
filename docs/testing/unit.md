<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Running unit tests</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

Running unit and integration tests with ElasTest doesn't require launching beforehand a [Sut](/#sut). The test itself will manage the execution of the tested software. So the only requirment is to create a TJob into a Project and launch it.

Here we will run our [JUnit5 Unit Test](https://github.com/elastest/demo-projects/tree/master/unit/junit5-unit-test) provided by default in ElasTest, which has a single class with two methods, sum and sub, that receive two numerical values to add or subtract respectively.
This test has been developed in Java using [JUnit5](https://junit.org/junit5/):

<div class="row">
<h5 class="small-subtitle">CalcTest class</h5>
<pre>
<code class="java">
public class CalcTest extends ElasTestBase {

    private Calc calc;

    static int left = 3;
    static int right = 2;

    @BeforeEach
    public void setup() {
        this.calc = new Calc();
    }

    @Test
    public void sumTest() {
        int expectedResult = 5;
        logger.info("Checking if {} + {} = {}", left, right, expectedResult);
        assertEquals(expectedResult, calc.sum(left, right));
    }

    @Test
    public void subTest() {

        int expectedResult = 1;
        logger.info("Checking if {} + {} = {}", left, right, expectedResult);
        assertEquals(expectedResult, calc.sub(left, right));
    }

}
</code>

</pre>
</div>

In addition, as can be seen in the example, this test class extends a class called ElasTestBase which is responsible for printing logs at the beginning and end of each test. These two logs have a specific structure and are used by ElasTest to filter the logs corresponding to each test. We will explain it in more detail <a href="#xmlAndtestResultsPath">below</a>

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

<h4 class="holder-subtitle link-top">Running the "JUnit5 Unit Test" TJob</h4>

To Run "JUnit5 Unit Test" TJob you only need follow these steps:

<h5 class="small-subtitle">1. Access your ElasTest dashboard</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/dashboard.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/dashboard.png"/></a>
</div>

<h5 class="small-subtitle">2. Get into "Unit Tests" project</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/project_selection.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/project_selection.png"/></a>
</div>

<h5 class="small-subtitle">3. Run the 'JUnit5 Unit Test' TJob</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/run_tjob.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/run_tjob.png"/></a>
</div>

<h5 class="small-subtitle">4. Execution screen is open automatically</h5>

<p>Our TJob will start running: you will see the test information and log.</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/execution_running.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/execution_running.png"/></a>
</div>

<p>Once the test is finished you will see the test results and log. Eventually the test should end succesfully.</p>

<p>
    <div class="range range-xs range-xs-center warning-range">
        <div class="cell-xs-2 cell-lg-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
        <div class="cell-xs-10 cell-lg-11 warning-text"><p><i>IMPORTANT: ElasTest make use of  <a href="#xmlAndtestResultsPath" title="View XML Report explanation">xml results file</a> to get all the test results information.</i></p></div>
    </div>
</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/execution_finished.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/execution_finished.png"/></a>
</div>

You can click on the Test Suite to display it and see each of the Test Cases. You can also click on one of them to navigate to the information section of this Test Case, where you can see their logs filtered thanks to the two traces of logs that the class ElasTestBase prints at the beginning and end of each test and that we have commented above. We are going to click on subTest:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/test_case_result.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/test_case_result.png"/></a>
</div>

You can click too on the **`View In LogAnalyzer`** button for navigate to <a href="/docs/log-analyzer/">Log Analyzer</a> Tool and view the execution logs:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/view_in_loganalyzer.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/view_in_loganalyzer.png"/></a>
</div>

Or you can click on the **`View Case In LogAnalyzer`** button view the specific test execution logs:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/view_case_in_loganalyzer.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/view_case_in_loganalyzer.png"/></a>
</div>

<!-- ****************************** -->
<!-- *** CREATING TJOB YOURSELF *** -->
<!-- ****************************** -->

<h4 class="holder-subtitle link-top">Creating a "JUnit5 Unit Test" TJob yourself</h4>
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

<h5 class="small-subtitle">3. Create a new TJob</h5>
You can create a new TJob by clicking on the button with the same name:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/project_page_new_tjob_btn.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/project_page_new_tjob_btn.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_3.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_3.png"/></a>
</div>

When a TJob is created, the minimum information that you have to provide is the following:

-   **TJob Name**: name of the TJob
-   **Select a SuT**: If your TJob make use of a Software under Test. In this case, none.
-   **Environment docker image**: the docker image that will host your test. This docker images should contain a client to download your code from your repository hosting service. For example, if your tests are hosted in GitHub and implemented in a Maven project with Java, you need to include a git client, Maven and the Java Development Kit (JDK) in the image.
    <!-- Modify when all images are available for testing with different hostsing services and technologies: Java, Maven, Pyhton, Ruby, Node... -->
-   **Commands**: these are the bash commands to be executed to download the code from a repository and to execute the tests. The specific commands depends on the source code repository type and the technology.

In our case, we will need to insert the following data for the TJob "JUnit5 Unit Test":

-   **TJob Name**: can be called as you want, but we will call it **`JUnit5 Unit Test`**
-   **Test Results Path**: **`/demo-projects/unit/junit5-unit-test/target/surefire-reports`**. This is the complete path where the xml reports of the execution in the container will be saved. We will explain it in more detail <a href="#xmlAndtestResultsPath">below</a>.
-   **Select a SuT**: **`None`**
-   **Environment docker image**: **`elastest/test-etm-alpinegitjava`** (image that contains Git, Maven and Java).
-   **Commands**:

          git clone https://github.com/elastest/demo-projects;
          cd /demo-projects/unit/junit5-unit-test;
          mvn -B test

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/new_tjob_junit5_unit_test.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/new_tjob_junit5_unit_test.png"/></a>
</div>

By clicking on SAVE the TJob will be saved and you will be redirected to the project page again, where you will be able to execute the TJob.

<h5 class="small-subtitle">4. Run the TJob from the Project's page</h5>
Click on the "Run TJob" button:
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/your-first-test/project_page_with_tjob.png"><img class="img-responsive img-wellcome" src="/docs/images/your-first-test/project_page_with_tjob.png"/></a>
</div>

<!-- ********************************* -->
<!-- * XML report, Test Results Path * -->
<!-- ********************************* -->

<h4 id="xmlAndtestResultsPath" class="holder-subtitle link-top">XML Report, Test Results Path and Start/End Test Traces</h4>
ElasTest makes use of xml reports generated by the tests to obtain the results.
The **`Test Results Path`** is the complete path of the test container where the xml reports of the execution will be saved.

The appearance of an xml report, such as the one generated when running the TJob JUnit5 Unit Test, is the following:

```
<?xml version="1.0" encoding="UTF-8"?>
<testsuite xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="https://maven.apache.org/surefire/maven-surefire-plugin/xsd/surefire-test-report.xsd" name="io.elastest.demo.unit.CalcTest" time="0.017" tests="2" errors="0" skipped="0" failures="0">
  <testcase name="subTest" classname="io.elastest.demo.unit.CalcTest" time="0.006"/>
  <testcase name="sumTest" classname="io.elastest.demo.unit.CalcTest" time="0"/>
</testsuite>
```

There is no official documentation on this xml format but you can find some examples on the internet, such as the following:

-   <a target="_blank" href="https://www.ibm.com/support/knowledgecenter/en/SSQ2R2_14.1.0/com.ibm.rsar.analysis.codereview.cobol.doc/topics/cac_useresults_junit.html">JUnit XML format</a>
-   <a target="_blank" href="http://help.catchsoftware.com/display/ET/JUnit+Format">JUnit Format</a>

Thanks to this file, ElasTest knows information about each of the executed tests, such as the result, the duration or its name.

In order to know which logs belong to each test and to be able to filter them, ElasTest looks for patterns in the logs that indicate the beginning and the end of the test. Both patterns must be printed on each test and have the following form:

-   **Start test trace**:

          ##### Start test: TESTNAME

-   **Finish test trace**:

          ##### Finish test: TESTNAME

Where **`TESTNAME`** is the name of the test. The way of obtaining the name of the test depends on the technology in which the test is developed:

-   In the case of **`JUnit5 Unit Test`** that we have used as an example above, it is developed in Java with JUnit5. As can be seen in the <a href="#elastestBaseCode">ElasTestBase code</a>, the name of the test is obtained by means of the testInfo parameter:
      
     testInfo.getTestMethod().get().getName()

-   We have included other example tests developed with other technologies. You can see it in the <a href="#moreExamples">More Examples section</a>

<!-- ********************************** -->
<!-- ********* Other Examples ********* -->
<!-- ********************************** -->

<h4 class="holder-subtitle link-top" id="moreExamples">More examples</h4>
The following examples, also offered by default in ElasTest, are implemented with different technologies:

<div class="badges-menu">
    <span id="junit4-btn" class="badge badge-default my-badge selected">Java JUnit4</span>
    <span id="python-btn" class="badge badge-default my-badge my-badge-disabled">Python</span>
    <span id="jasmine-btn" class="badge badge-default my-badge my-badge-disabled">JS Jasmine</span>
</div>

<!-- JUNIT4 -->
<div id="junit4" class="testExample badge-tutorial">
You can view the <a target="_blank" href="https://github.com/elastest/demo-projects/tree/master/unit/junit4-unit-test">Source Code in GitHub</a>.
This test has been developed in Java using <a target="_blank" href="https://junit.org/junit4/">JUnit4</a>.

<div class="row">
<h5 class="small-subtitle">CalcTest class</h5>
<pre>
<code class="java">
public class CalcTest extends ElasTestBase {

    private Calc calc;

    static int left = 3;
    static int right = 2;

    @Before
    public void setup() {
        this.calc = new Calc();
    }

    @Test
    public void sumTest() {
        int expectedResult = 5;
        logger.info("Checking if {} + {} = {}", left, right, expectedResult);
        assertEquals(expectedResult, calc.sum(left, right));
    }

    @Test
    public void subTest() {
        int expectedResult = 1;
        logger.info("Checking if {} + {} = {}", left, right, expectedResult);
        assertEquals(expectedResult, calc.sub(left, right));
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
<li><strong>TJob Name</strong>: can be called as you want, but we will call it <strong><code>JUnit4 Unit Test</code></strong></li>
<li><strong>Test Results Path</strong>: <strong><code>/demo-projects/unit/junit4-unit-test/target/surefire-reports</code></strong></li>
<li><strong>Select a SuT</strong>: <strong><code>None</code></strong></li>
<li><strong>Environment docker image</strong>: <strong><code>elastest/test-etm-alpinegitjava</code></strong></li>
<li><strong>Commands</strong>: 
<pre>
    <code>
    git clone https://github.com/elastest/demo-projects;
    cd /demo-projects/unit/junit4-unit-test;
    mvn -B test
    </code>
</pre>
</li>
</ul>

</div>

<!-- PYTHON -->
<div id="python" class="testExample badge-tutorial">
You can view the <a target="_blank" href="https://github.com/elastest/demo-projects/tree/master/unit/python-unit-test">Source Code in GitHub</a>.
This test has been developed in <a target="_blank" href="https://www.python.org/">Python</a>.

<div class="row">
<h5 class="small-subtitle">TestUnit class</h5>
<pre>
<code class="python">

import unittest
import os
import sys
import xmlrunner
import ElasTestBase
from Calc import \*

leftOperand = 3
rightOperand = 2

class TestUnit(ElasTestBase.ElasTestBase):

    def test_sum(self):
        global leftOperand
        global rightOperand
        expected = 5

        print 'Checking if ' + str(leftOperand) + ' + ' + \
            str(rightOperand) + ' = '+str(expected)

        self.assertEqual(sum(leftOperand, rightOperand), expected)

    def test_sub(self):
        global leftOperand
        global rightOperand
        expected = 1

        print 'Checking if ' + str(leftOperand) + ' - ' + \
            str(rightOperand) + ' = '+str(expected)

        self.assertEqual(sub(leftOperand, rightOperand), expected)

if **name** == '**main**':
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

class ElasTestBase(unittest.TestCase):
def setUp(self):
print '##### Start test: ' + self.\_testMethodName

    def tearDown(self):
        print '##### Finish test: ' + self._testMethodName

</code>
</pre>
</div>

<h5 class="small-subtitle">TJob Configuration</h5>

<ul>
<li><strong>TJob Name</strong>: can be called as you want, but we will call it <strong><code>Python Unit Test</code></strong></li>
<li><strong>Test Results Path</strong>: <strong><code>/demo-projects/unit/python-unit-test/testresults</code></strong></li>
<li><strong>Select a SuT</strong>: <strong><code>None</code></strong></li>
<li><strong>Environment docker image</strong>: <strong><code>elastest/test-etm-alpinegitpython</code></strong></li> (Alpine image with Git and Python)
<li><strong>Commands</strong>: 
<pre>
    <code>
    git clone https://github.com/elastest/demo-projects;
    cd /demo-projects/unit/python-unit-test;
    python UnitTest.py;
    </code>
</pre>
</li>
</ul>

</div>

<!-- JASMINE -->
<div id="jasmine" class="testExample badge-tutorial">
You can view the <a target="_blank" href="https://github.com/elastest/demo-projects/tree/master/unit/jasmine-unit-test">Source Code in GitHub</a>.
This test has been developed in Javascript using <a target="_blank" href="https://jasmine.github.io/">Jasmine</a>.

<div class="row">
<h5 class="small-subtitle">unit-test-spec.js</h5>
<pre>
<code class="javascript">
require('./elastest-conf.js');
var calc = require('../calc.js');

leftOperand = 3;
rightOperand = 2;

describe('Unit Test', function() {
it('Sum', function() {
expectedResult = 5;
console.log('Checking if ' + leftOperand + ' + ' + rightOperand + ' = ' + expectedResult);
expect(calc.sum(leftOperand, rightOperand)).toEqual(expectedResult);
});

    it('Sub', function() {
        expectedResult = 1;
        console.log('Checking if ' + leftOperand + ' - ' + rightOperand + ' = ' + expectedResult);
        expect(calc.sub(leftOperand, rightOperand)).toEqual(expectedResult);
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
</code>

</pre>
</div>

<h5 class="small-subtitle">TJob Configuration</h5>

<ul>
<li><strong>TJob Name</strong>: can be called as you want, but we will call it <strong><code>Jasmine Unit Test</code></strong></li>
<li><strong>Test Results Path</strong>: <strong><code>/demo-projects/unit/jasmine-unit-test/testresults</code></strong></li>
<li><strong>Select a SuT</strong>: <strong><code>None</code></strong></li>
<li><strong>Environment docker image</strong>: <strong><code>elastest/test-etm-alpinegitnode</code></strong></li> (Alpine image with Git, Node, and necessary libraries like jasmine)
<li><strong>Commands</strong>: 
<pre>
    <code>
    git clone https://github.com/elastest/demo-projects;
    cd /demo-projects/unit/jasmine-unit-test;
    jasmine;
    </code>
</pre>
</li>
</ul>
</div>

<!-- ********************* -->
<!-- ****** Scripts ****** -->
<!-- ********************* -->

<script>
$('#junit4-btn').click(function(event) {
  activateBadge('junit4');
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
