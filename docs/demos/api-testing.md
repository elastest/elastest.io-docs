<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">API Testing</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<p>A sample application (backend+db) exposing a REST API is started automatically. The test exercises the REST API. Logs & metrics for app & db are collected automatically.</p>

<div class="run-div">
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-5">
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
                        <p class="docker-subtitle">Recommended system specifications</p>
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
@DisplayName("Tests for Fullteaching login")
public class UserRestTest {

    protected static String APP_URL;
    **`protected static String ET_SUT_HOST;**`
    protected static int ET_SUT_PORT = 5000;
    private HttpApiClient httpApiClient;

    // urls
    static String new_user_uri = "/api-users/new";
    static String change_password_uri = "/api-users/changePassword";
    static String login_uri = "/api-logIn";
    // userStrings
    static String ok_parameters = "[\"unique@gmail.com\", \"Mock66666\", \"fakeUser\", \"IGNORE\"]";
    static String ok_parameters_2 = "[\"unique2@gmail.com\", \"Mock66666\", \"fakeUser\", \"IGNORE\"]";
    // passParameters
    static String pass_parameters = "[\"Mock66666\", \"Mock77777\"]";
    static String revert_pass_parameters = "[\"Mock77777\", \"Mock66666\"]";

    @BeforeAll
    public static void setUp() {
        if (System.getenv("ET_SUT_HOST") != null) {
            ET_SUT_HOST = System.getenv("ET_SUT_HOST");
        } else {
            ET_SUT_HOST = System.getProperty("sut.host");
            if (ET_SUT_HOST == null) {
                ET_SUT_HOST = "localhost";
            }
        }

        if (System.getenv("ET_SUT_PORT") != null) {
            if (!System.getenv("ET_SUT_PORT").isEmpty()) {
                ET_SUT_PORT = Integer.parseInt(System.getenv("ET_SUT_PORT"));
            } else {
                ET_SUT_PORT = 0;
            }
        }
    }

    @Test
    public void testCreateUserOk() {
        try {
            // Create the user if it doesn't exist
            int status = createUser(ok_parameters);

            int expected = HttpStatus.CREATED.value();

            assertEquals(expected, status,
                    "failure - expected HTTP status " + expected);
        } catch (IOException | KeyManagementException | NoSuchAlgorithmException
                | KeyStoreException e) {
            e.printStackTrace();
            fail("EXCEPTION: " + e.getMessage());
        }
    }

    @Test
    public void testChangeUserPassword() {
        try {
            // Create the user if it doesn't exist
            createUser(ok_parameters_2);

            // Change the user's password
            httpApiClient = new HttpApiClient(null, ET_SUT_HOST, ET_SUT_PORT,
                    change_password_uri, "unique2@gmail.com", "Mock66666");

            int status_pass = httpApiClient.sendRequest(pass_parameters, "put");
            assertTrue(status_pass == HttpStatus.OK.value(),
                    "failure login - expected HTTP status "
                            + HttpStatus.OK.value() + " but was: "
                            + status_pass);

            // Revert the change of user password
            httpApiClient = new HttpApiClient(null, ET_SUT_HOST, ET_SUT_PORT,
                    change_password_uri, "unique2@gmail.com", "Mock77777");

            httpApiClient.sendRequest(revert_pass_parameters, "put");

        } catch (IOException | KeyManagementException | NoSuchAlgorithmException
                | KeyStoreException e) {
            e.printStackTrace();
            fail("EXCEPTION: " + e.getMessage());
        }
    }

    private int createUser(String parameters) throws KeyManagementException,
            NoSuchAlgorithmException, KeyStoreException, IOException {
        httpApiClient = new HttpApiClient(null, ET_SUT_HOST, ET_SUT_PORT,
                new_user_uri, null, null);

        return httpApiClient.sendRequest(parameters, "post");
    }

}
```

>-  **`ET_SUT_HOST`**, **`ET_SUT_PORT`**  variables will be the IP and port of our SuT respectively. (Know more about <a href="/docs/testing/environment-variables/">Environment Variables</a>)

<h5 class="small-subtitle">Jenkins <i class="fab fa-jenkins"></i></h5>

```groovy
node{
    def sutIp
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage("Setting environment") {
            echo 'Environment variables'
            sh "env"
            git "https://github.com/elastest/full-teaching-experiment.git"
        }
        try {
            stage("Start Sut") {
                sh "cd docker-compose/full-teaching-et-network; export BUG_TAG=demo; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
                sutContainerName = env.ET_SUT_CONTAINER_NAME + "_full-teaching_1";
                sutNetwork = getFirstNetwork(sutContainerName)
                sutIp = containerIp(sutContainerName,network)

                echo 'Sut ip: '+ sutIp
                sh 'docker run -e IP=' + sutIp + ' -e PORT=5001 --network=' + sutNetwork + ' elastest/etm-check-service-up'
            }
            stage("Run Tests") {
                echo 'Running test'
                mvnHome = tool 'M3.3.9'
                sh "export ET_SUT_PORT=5001; '${mvnHome}/bin/mvn' -Dtest=UserRestTest -Dsut.host=" + sutIp +" -B -DforkCount=0 test"
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