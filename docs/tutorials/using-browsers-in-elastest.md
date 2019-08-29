<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Using browser in ElasTest</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

Once started ElasTest, you can make use of the Jenkins instance provided, which contains some example jobs loaded by default.

If you did not start ElasTest with the **`--jenkins`** parameter (see how to [start ElasTest](/try-elastest) and its parameters), the Jenkins instance will not be available but you can start it manually from the ElasTest GUI navigating to the **`Jenkins`** section and clicking on the **`Start Jenkins`** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"/></a>
</div>

Jenkins start progress will be shown:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_starting.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_starting.png"/></a>
</div>

Once started, a button to open Jenkins in a new browser tab and another button to show the access credentials will be shown (If you started Jenkins with ElasTest --jenkins parameter, these buttons will be displayed directly)

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_started_marked.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Launch web browser Job width Jenkins Plugin</h4>

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

>-  **`ET_SUT_HOST`**, **`ET_SUT_PORT`**  variables will be the IP and port of our SuT respectively. (Know more about <a href="/docs/testing/environment-variables/">Environment Variables</a>)

<h5 class="small-subtitle">Jenkins <i class="fab fa-jenkins"></i></h5>

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
                sh "cd docker-compose/full-teaching-without-network; export BUG_TAG=demo; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
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

-   **ElasTest plugin block with configuration** : this block will contain all the steps that the test must follow, as well as the necessary [configuration options](#options).

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
