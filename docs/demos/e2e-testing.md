<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">E2E testing</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<p>A sample videoconferencing applications (backend+media server+db) is started automatically. The test exercises the videoconferencing features through the UI by means of a couple of browsers. Logs, metrics and videos are collected automatically.</p>

<div class="run-div">
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12">
            <img src="/docs/images/logo-dark.png" style="border: none; padding-top: 14px;" alt="" />
        </div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="http://live.elastest.io:37000/#/projects/8/tjob/34/tjob-exec/56" class="btn btn-xs btn-primary" title="Try it now">Try it now</a>
        </div>
    </div>
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12"><img src="/docs/images/docker.png" style="border: none;" alt="" /></div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <div class="row no-margin">
                <div class="col-lg-1 col-md-2 col-sm-2 no-padding">
                    <button id="btn-copy-2" class="btn btn-xs btn-primary" data-toggle="tooltip" data-placement="button"
                    title="Copy to Clipboard">Copy</button>
                </div>
                <div class="col-lg-11 col-md-10 col-sm-10 no-padding">
                    <code id="code-2">docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start</code>
                </div>
                <br/>
                <div class="row no-margin docker-info-div">
                    <div class="col-lg-1 col-md-2 col-sm-2 no-padding docker-info-icon">
                        <i class="fas fa-info-circle"></i>
                    </div>
                    <div class="col-lg-11 col-md-10 col-sm-10 no-padding">
                        <h4 class="small-subtitle">Recommended system specifications</h4>
                        <p>ElasTest needs some minimum system specifications in order to run smoothly:</p>
                        <table>
                            <tr>
                                <td>Processor</td>
                                <td>1GHz or faster</td>
                            </tr>
                            <tr>
                                <td>RAM</td>
                                <td>16GB</td>
                            </tr>
                            <tr>
                                <td>SWAP</td>
                                <td>4GB (if RAM < 16GB)</td>
                            </tr>
                            <tr>
                                <td>Hard Disk</td>
                                <td>30GB</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12"><img src="/docs/images/amazonAWS.png" style="border: none;" alt="" /></div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="/docs/deploying/aws/" class="btn btn-xs btn-primary" title="Deploy on Amazon">Deploy on Amazon</a>
        </div>
    </div>
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12"><img src="/docs/images/kubernetes.png" style="border: none; max-height: 124px; padding-top: 8px;" alt="" /></div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="/docs/deploying/kubernetes" class="btn btn-xs btn-primary" data-toggle="tooltip" data-placement="button"
                    title="On quarter 3">Deploy on Kubernetes (Q3)</a>
        </div>
    </div>
    <hr />
</div>

<h5 class="small-subtitle">Test <i class="fab fa-java"></i></h5>

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

The enpoint for the application is defined in the `FullTrachingTestE2E` class. In the next box we observe the block of code that define the endpoint. we can observe the complete code in this [link](https://github.com/elastest/full-teaching-experiment/blob/master/src/test/java/com/fullteaching/backend/e2e/FullTeachingTestE2E.java).

```java
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
    }
```

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