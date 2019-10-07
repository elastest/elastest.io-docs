<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Using browser in ElasTest</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h3 class="small-subtitle">Launch web browser Job without SUT with Jenkins Plugin</h3>

We will use the browsers in ElasTest, we use a simple test that open a google page and search. The test has following:

##### **UseBrowser class**

```java
public class UseBrowser extends ElastestBaseTest{
    protected static final Logger logger = LoggerFactory
            .getLogger(UseBrowser.class);

	@Test
	public void searchInGoogle() {
		String URL = "https://google.com/";

		this.driver.get(URL);
		logger.info("Go to http://google.es/...");

		sleep(2000);

		logger.info("Searching 'test' word...");
		WebElement searchInput = driver.findElement(By.xpath("//input[@class='gLFyf gsfi']"));
		searchInput.sendKeys("test");
		searchInput.sendKeys(Keys.ENTER);

		sleep(2000);

		logger.info("Finish test correctly");
	}

	public void sleep(int time) {
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
```

We will see that the test extends the class **`ElastestBaseTest`**, this class is nedded for using the browser in ElasTest. We see the class in the following box:

##### **ElastestBaseTest class**

```java
public class ElastestBaseTest {
    protected static final Logger logger = LoggerFactory
            .getLogger(ElastestBaseTest.class);

    protected static final String CHROME = "chrome";
    protected static final String FIREFOX = "firefox";

    protected static String browserType;
    protected static String browserVersion;
    protected static String eusURL;
    protected static String sutUrl;

    protected WebDriver driver;

    @BeforeAll
    public static void setupClass() {
        String sutHost = System.getenv("ET_SUT_HOST");
        String sutPort = System.getenv("ET_SUT_PORT");
        String sutProtocol = System.getenv("ET_SUT_PROTOCOL");

        if (sutHost == null) {
            sutUrl = "http://localhost:8080/";
        } else {
            sutPort = sutPort != null ? sutPort : "8080";
            sutProtocol = sutProtocol != null ? sutProtocol : "http";

            sutUrl = sutProtocol + "://" + sutHost + ":" + sutPort;
        }
        logger.info("Webapp URL: " + sutUrl);

        browserType = System.getProperty("browser");
        logger.info("Browser Type: {}", browserType);
        eusURL = System.getenv("ET_EUS_API");

        if (eusURL == null) {
            if (browserType == null || browserType.equals(CHROME)) {
                WebDriverManager.chromedriver().setup();
            } else {
                WebDriverManager.firefoxdriver().setup();
            }
        }
    }

    @BeforeEach
    public void setupTest(TestInfo info) throws MalformedURLException {
        String testName = info.getTestMethod().get().getName();
        logger.info("##### Start test: {}", testName);

        if (eusURL == null) {
            if (browserType == null || browserType.equals(CHROME)) {
                driver = new ChromeDriver();
            } else {
                driver = new FirefoxDriver();
            }
        } else {
            DesiredCapabilities caps;
            if (browserType == null || browserType.equals(CHROME)) {
                caps = DesiredCapabilities.chrome();
            } else {
                caps = DesiredCapabilities.firefox();
            }

            browserVersion = System.getProperty("browserVersion");
            if (browserVersion != null) {
                logger.info("Browser Version: {}", browserVersion);
                caps.setVersion(browserVersion);
            }

            caps.setCapability("testName", testName);
            driver = new RemoteWebDriver(new URL(eusURL), caps);
        }

        driver.get(sutUrl);
    }

    @AfterEach
    public void teardown(TestInfo info) {
        if (driver != null) {
            driver.quit();
        }

        String testName = info.getTestMethod().get().getName();
        logger.info("##### Finish test: {}", testName);
    }

}
```

> -   **`ET_SUT_HOST`**, **`ET_SUT_PORT`** and **`ET_SUT_PROTOCOL`** variables will be the IP, port and protocol of our SuT respectively. ElasTest will automatically inject the right value (Know more about <a href="/docs/testing/environment-variables/">Environment Variables</a>)

> -   **`ET_EUS_API`** variable tells us where to connect to use Elastest browsers (standard Selenium Hub). If the variable has no value, we can consider that this service is no available and then local browsers have to be used (here we are using <a href="https://github.com/bonigarcia/webdrivermanager" target="_blank">WebDriver Manager</a> Java library. This library is responsible to download and configure any additional software needed to use installed browsers from tests)

> -   The values of the variables **browserType** and **browserVersion** are taken from the **properties** browser and browserVersion respectively, which you can pass in the test run command with **`-Dbrowser=chrome`**.

#### **Jenkins Pipeline** <i class="fab fa-jenkins"></i>

```groovy
node{
    elastest(tss: ['EUS'], surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage ('Executing Test') {
            echo 'Set up test environment'
            mvnHome = tool 'M3.3.9'
            echo 'Cloning repository'
            git 'https://github.com/elastest/demo-projects'
            echo 'Running Test'
            sh "cd ./basic-using-browser/;'${mvnHome}/bin/mvn' -Dtest=UseBrowser -Dbrowser=chrome test"
        }
    }
}
```

The example above can be split into the following sections:

<p></p>

-   **ElasTest plugin block with configuration** : this block will contain all the steps that the test must follow, as well as the necessary [configuration options](#options). In this case is very important the part **`tss: ['EUS']`** because allow us use the browsers.

<p></p>

```groovy
node{
    elastest(tss: ['EUS'], surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        .......
    }
}
```

<p></p>

-   **Test Execution** : Dowload the git project and execution test, we change the type of browser with the variable **`-Dbrowser=`**, and define the version with the variable **`-DbrowserVersion=`**

<p></p>

#### **Launch**

##### 1. Access your Jenkins

When you will open Jenkins click in the **`New Item`**

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/browser/jenkins-basic-browser-new-item.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/jenkins-basic-browser-new-item.png"/></a>
</div>

##### 2. Define the name and type the Job

Input the **`UsingBrowserInElasTest`** and select the **`Pipeline`** option them click in the **`Ok`** button:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/browser/jenkins-basic-browser-define-item.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/jenkins-basic-browser-define-item.png"/></a>
</div>

##### 3. You add the **Pipeline**

Copy the [ElasTest Pipeline](#jenkins-pipeline) and paste in the **Pipeline** section, as follows:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/browser/jenkins-basic-browser-create-pipeline.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/jenkins-basic-browser-create-pipeline.png"/></a>
</div>

##### 4. Inside Pipeline page

When we inside into the Pipeline page we will click in the **`Build Now`** to launch the Job in ElasTest

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/browser/jenkins-basic-browser-build-now.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/jenkins-basic-browser-build-now.png"/></a>
</div>

##### 5. Go to the TJob execution screen

Entering the build page, you will see the Open in ElasTest button, where you can see the execution page in ElasTest (If the button does not appear refresh the page, it may take a while).

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/browser/jenkins-basic-browser-open-in-elastest.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/jenkins-basic-browser-open-in-elastest.png"/></a>
</div>

When the TJob was opened you will see the video of the browser session and logs:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/browser/basic-browser-execution.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/basic-browser-execution.png"/></a>
</div>

Gif with the video of the browser session:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/browser/browser-session.gif"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/browser-session.gif"/></a>
</div>

<br>
<hr>
<br>

<h3 class="small-subtitle">Launch web browser Job and SUT with Jenkins Plugin</h3>

We using a Full-Teaching application for this tutorial. Now we run the Full-Teaching with bug for show the logs.

```java
@Tag("e2e")
@DisplayName("E2E tests for FullTeaching REST CRUD operations")
@ExtendWith(SeleniumExtension.class)
public class FullTeachingTestE2EREST extends FullTeachingTestE2E {

	private static String BROWSER;

	final String TEST_COURSE = "TEST_COURSE";
	final String TEST_COURSE_INFO = "TEST_COURSE_INFO";
	final String EDITED = " EDITED";

	final String TEACHER_MAIL = "teacher@gmail.com";
	final String TEACHER_PASS = "pass";
	final String TEACHER_NAME = "Teacher Cheater";

	String COURSE_NAME = TEST_COURSE;

	static Exception ex = null;

	BrowserUser user;

	public FullTeachingTestE2EREST() {
		super();
	}

	/*** ClassRule methods ***/

	@BeforeAll()
	static void setupAll() {
		BROWSER = System.getenv("BROWSER");

		if ((BROWSER == null) || (!BROWSER.equals(FIREFOX))) {
			BROWSER = CHROME;
		}

		log.info("Using URL {} to connect to openvidu-testapp", APP_URL);
	}

	@BeforeEach
	void setup(TestInfo info) {

		log.info("##### Start test: " + info.getTestMethod().get().getName());

		loginTeacher(info); // Teacher login
		addCourse(COURSE_NAME); // Add test course
	}

	@AfterEach
	void dispose(TestInfo info) {
		try {
			this.deleteCourseIfExist();
			this.logout(user);
			user.dispose();
		} finally {
			log.info("##### Finish test: " + info.getTestMethod().get().getName());
		}
	}

	/*** Test methods ***/

	@Test
	void courseRestOperations() throws Exception {

		// Edit course

		log.info("Editing course");

		COURSE_NAME = COURSE_NAME + EDITED;

		List<WebElement> l = user.getDriver().findElements(By.className("course-put-icon"));
		openDialog(l.get(l.size() - 1), user);

		user.waitUntil(ExpectedConditions.elementToBeClickable(By.id(("input-put-course-name"))),
				"Input for course name not clickable");
		user.getDriver().findElement(By.id("input-put-course-name")).clear();
		user.getDriver().findElement(By.id("input-put-course-name")).sendKeys(COURSE_NAME);
		user.getDriver().findElement(By.id("submit-put-course-btn")).click();

		waitForDialogClosed("course-modal", "Edition of course failed", user);

		user.waitUntil(
				ExpectedConditions.textToBe(
						By.cssSelector("#course-list .course-list-item:last-child div.course-title span"), COURSE_NAME),
				"Unexpected course name");

	}

	....
```

We can observe the all code in this [link](https://github.com/elastest/full-teaching-experiment/blob/master/src/test/java/com/fullteaching/backend/e2e/FullTeachingTestE2EREST.java).

> -   The test mark the init of the test case in the **`setup`** method and the finish of the test case in the **`dispose`** method. With the code `log.info("##### Start test: " + info.getTestMethod().get().getName());`and `log.info("##### Finish test: " + info.getTestMethod().get().getName());` respectively.

```java
@ExtendWith(SeleniumExtension.class)
public class FullTeachingTestE2E {

    protected static String APP_URL;

    protected static final String CHROME = "chrome";
    protected static final String FIREFOX = "firefox";

    final static Logger log = getLogger(lookup().lookupClass());

    public FullTeachingTestE2E() {
        if (System.getenv("ET_EUS_API") == null) {
            // Outside ElasTest
            ChromeDriverManager.getInstance().setup();
            FirefoxDriverManager.getInstance().setup();
        }

        if (System.getenv("ET_SUT_HOST") != null) {
            APP_URL = "https://" + System.getenv("ET_SUT_HOST") + ":5000/";
        } else {
            APP_URL = System.getProperty("app.url");
            if (APP_URL == null) {
                APP_URL = "https://localhost:5000/";
            }
        }
...
```

We can observe the all code in this [link](https://github.com/elastest/full-teaching-experiment/blob/master/src/test/java/com/fullteaching/backend/e2e/FullTeachingTestE2E.java).

> -   **`ET_SUT_HOST`**, **`ET_SUT_PORT`** variables will be the IP of our SuT respectively. ElasTest will automatically inject the right value (Know more about <a href="/docs/testing/environment-variables/">Environment Variables</a>)

#### **Jenkins** <i class="fab fa-jenkins"></i>

```groovy
node{
    def sutIp
    elastest(tss: ['EUS'], surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage("Setting environment") {
            echo 'Environment variables'
            sh "env"
            git "https://github.com/elastest/full-teaching-experiment.git"
        }
        try {
            stage("Start Sut") {
                sh "cd docker-compose/full-teaching-without-network; export BUG_TAG=bug2; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
                sutContainerName = env.ET_SUT_CONTAINER_NAME + "_full-teaching_1";
                sutNetwork = getFirstNetwork(sutContainerName)
                sutIp = containerIp(sutContainerName,network)

                echo 'Sut ip: '+ sutIp
                sh 'docker run -e IP=' + sutIp + ' -e PORT=5001 --network=' + sutNetwork + ' elastest/etm-check-service-up'
            }
        	stage("Run Tests") {
                echo 'Running test'
                mvnHome = tool 'M3.3.9'
                sh "'${mvnHome}/bin/mvn' -Dapp.url=https://" + sutIp +":5001/ -Dtest=FullTeachingTestE2EREST -B -DforkCount=0 test"
                step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
        	}
        } finally {
                echo 'Stopping SUT'
                sh "cd docker-compose/full-teaching-env; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
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

-   **ElasTest plugin block with configuration** : this block will contain all the steps that the test must follow, as well as the necessary [configuration options](#options). In this case is very important the part **`tss: ['EUS']`** because allow us use the browsers.

<p></p>

```groovy
node{
    elastest(tss: ['EUS'], surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        .......
    }
}
```

<p></p>

-   **Sut configuration** : The SUT must be started, passing the **`${env.ET_SUT_CONTAINER_NAME}`** env variable (provided by ElasTest) as name of the container. This will allow ElasTest to receive logs and metrics from the Sut.

<p></p>

```groovy
sh "cd docker-compose/full-teaching-without-network; export BUG_TAG=bug2; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
sutContainerName = env.ET_SUT_CONTAINER_NAME + "_full-teaching_1";
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

<p></p>

-   **Test Execution** : Finally, the tests should be executed to verify that the SUT is working correctly. Remember that you have to configure the Sut ip as an environment variable or pass it as a maven property so that the test knows where the SUT is.

<p></p>

```groovy
stage("Run Tests") {
    echo 'Running test'
    mvnHome = tool 'M3.3.9'
    sh "'${mvnHome}/bin/mvn' -Dapp.url=https://" + sutIp +":5001/ -Dtest=FullTeachingTestE2EREST -B -DforkCount=0 test"
    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
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

To run the Test in Jenkins first create a new **`Item`**, after enter the **`FullTeaching Browser`** name and select the
**`Pipeline`** optinion. Finally click in **`Ok`** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/browser/new-item.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/new-item.png"/></a>
</div>

After, you write the [Pipeline](#jenkins) and paste in the **`Pipeline`** section. After click the **`Save`** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/browser/create-pipeline.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/create-pipeline.png"/></a>
</div>

When the **`Job`** was created, you click in the **`Build Run`**:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/browser/run-Tjob.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/run-Tjob.png"/></a>
</div>

We will see the finish execution in Jenkins:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/browser/execution-jenkins.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/execution-jenkins.png"/></a>
</div>

Finally we can see the TJob execution in ElasTest:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/tutorials/images/browser/tjob.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/browser/tjob.png"/></a>
</div>

<br>
<hr>
<br>

<h3 class="small-subtitle" id="browsersInAWS">Launching ElasTest web browsers in AWS</h3>

Sometimes, it is useful to launch ElasTest browsers in AWS, which would allow to launch as many browsers as we want. This is a typical scenario when load tests are performed. ElasTest allows you to easily configure it to launch all browsers requested in AWS instances, just by configuring the EUS service to use AWS.

Elastest can also start browsers on an **AWS** instance. For this, it is necessary to send the configuration through the test through a special capability called **`awsConfig`**, which must have a specific format:

```json
{
    "region": "eu-west-1",
    "secretAccessKey": "secretAccessKey",
    "accessKeyId": "accessKeyId",
    "sshUser": "sshUser",
    "sshPrivateKey": "sshPrivateKey",
    "awsInstancesConfig": {
        "amiId": "ami-0bfc646d9bb6ad37c",
        "instanceType": "instanceType",
        "keyName": "keyName",
        "numInstances": 1,
        "securityGroups": ["group1", ...],
        "tagSpecifications": [
            {
                "resourceType":"instance",
                "tags":[
                     {"key":"key", "value":"value"}
                ]
            },
            ...
        ]
    }
}
```

**`amiId`** and **`region`** values **must** be as above.

We could **adapt** the code of our **`ElastestBaseTest.class from the first example`** to use browsers in **AWS**. For this we have added the **`initAwsConfig`** method that is called in the *@BeforeAll* and initializes the awsConfig object from values that can be sent in environment variables. Afterwards, you only need to add the awsConfig object to a **capability**.

##### **ElastestBaseTest class**

```java
public class ElastestBaseTest {
    protected static final Logger logger = LoggerFactory
            .getLogger(ElastestBaseTest.class);

    protected static final String CHROME = "chrome";
    protected static final String FIREFOX = "firefox";

    protected static String browserType;
    protected static String browserVersion;
    protected static String eusURL;
    protected static String sutUrl;
    protected static JsonObject awsConfig;

    protected WebDriver driver;

    @BeforeAll
    public static void setupClass() {
        String sutHost = System.getenv("ET_SUT_HOST");
        String sutPort = System.getenv("ET_SUT_PORT");
        String sutProtocol = System.getenv("ET_SUT_PROTOCOL");

        if (sutHost == null) {
            sutUrl = "http://localhost:8080/";
        } else {
            sutPort = sutPort != null ? sutPort : "8080";
            sutProtocol = sutProtocol != null ? sutProtocol : "http";

            sutUrl = sutProtocol + "://" + sutHost + ":" + sutPort;
        }
        logger.info("Webapp URL: " + sutUrl);

        browserType = System.getProperty("browser");
        logger.info("Browser Type: {}", browserType);
        eusURL = System.getenv("ET_EUS_API");

        if (eusURL == null) {
            if (browserType == null || browserType.equals(CHROME)) {
                WebDriverManager.chromedriver().setup();
            } else {
                WebDriverManager.firefoxdriver().setup();
            }
        }

        initAwsConfig();
    }

    @BeforeEach
    public void setupTest(TestInfo info) throws MalformedURLException {
        String testName = info.getTestMethod().get().getName();
        logger.info("##### Start test: {}", testName);

        if (eusURL == null) {
            if (browserType == null || browserType.equals(CHROME)) {
                driver = new ChromeDriver();
            } else {
                driver = new FirefoxDriver();
            }
        } else {
            DesiredCapabilities caps;
            if (browserType == null || browserType.equals(CHROME)) {
                caps = DesiredCapabilities.chrome();
            } else {
                caps = DesiredCapabilities.firefox();
            }

            browserVersion = System.getProperty("browserVersion");
            if (browserVersion != null) {
                logger.info("Browser Version: {}", browserVersion);
                caps.setVersion(browserVersion);
            }

            caps.setCapability("testName", testName);

            // AWS capabilities for browsers
            ObjectMapper mapper = new ObjectMapper();
            Map<String, String> awsConfigMap = mapper
                    .readValue(awsConfig.toString(), Map.class);

            capabilities.setCapability("awsConfig", awsConfigMap);

            driver = new RemoteWebDriver(new URL(eusURL), caps);
        }

        driver.get(sutUrl);
    }

    @AfterEach
    public void teardown(TestInfo info) {
        if (driver != null) {
            driver.quit();
        }

        String testName = info.getTestMethod().get().getName();
        logger.info("##### Finish test: {}", testName);
    }

    public JsonObject initAwsConfig(){
        awsConfig = new JsonObject();

        // Aws Config
        String region = System.getenv("AWS_REGION");
        String secretAccessKey = System.getenv("AWS_SECRET_ACCESS_KEY");
        String accessKeyId = System.getenv("AWS_ACCESS_KEY_ID");
        String sshUser = System.getenv("AWS_SSH_USER");
        String sshPrivateKey = System.getenv("AWS_SSH_PRIVATE_KEY");

        // Instances config
        String awsAmiId = System.getenv("AWS_AMI_ID");
        String instanceType = System.getenv("AWS_INSTANCE_TYPE");
        String keyName = System.getenv("AWS_KEY_NAME");
        String securityGroups = System.getenv("AWS_SECURITY_GROUPS");
        String tagSpecifications = System.getenv("AWS_TAG_SPECIFICATIONS");
        int numInstances = Integer.parseInt(System.getenv("AWS_NUM_INSTANCES"));

        JsonParser parser = new JsonParser();

        awsConfig.addProperty("region", region);
        awsConfig.addProperty("secretAccessKey", secretAccessKey);
        awsConfig.addProperty("accessKeyId", accessKeyId);
        awsConfig.addProperty("sshUser", sshUser);
        awsConfig.addProperty("sshPrivateKey",
                sshPrivateKey.replace("\\r\\n", System.lineSeparator()));

        // Instances Config

        JsonObject awsInstancesConfig = new JsonObject();
        awsInstancesConfig.addProperty("amiId", awsAmiId);
        awsInstancesConfig.addProperty("instanceType", instanceType);
        awsInstancesConfig.addProperty("keyName", keyName);

        awsInstancesConfig.addProperty("numInstances", numInstances);
        JsonArray securityGroupsElement = parser.parse(securityGroups)
                .getAsJsonArray();
        awsInstancesConfig.add("securityGroups", securityGroupsElement);

        JsonArray tagSpecificationsElement = parser.parse(tagSpecifications)
                .getAsJsonArray();
        awsInstancesConfig.add("tagSpecifications", tagSpecificationsElement);
        awsConfig.add("awsInstancesConfig", awsInstancesConfig);
        return awsConfig;
    }

}
```
