<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Running end to end tests (REST APIs)</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<div class="badges-menu">
    <span class="badge badge-default my-badge selected">Java</span>
    <span class="badge badge-default my-badge my-badge-disabled">Node</span>
    <span class="badge badge-default my-badge my-badge-disabled">PHP</span>
    <span class="badge badge-default my-badge my-badge-disabled">. . .</span>
</div>

Unit and integration tests are important to verify that isolated and integrated software modules are behaving as expected. Nevertheless, **end to end tests** (sometimes called system tests) are also important, because they allow to test the system as a whole, as seen for the end user. End to end tests are different from unit and integration tests because the [SuT](/fundamentals/core-concepts/) is deployed in the same environment as in production.

To execute an end to end test in ElasTest, the SuT have to be declared explicitly. Then, any TJob can be associated to that SuT. In this way, the SuT can be managed independently the number of TJob executed against it.

Here we will run our [REST Java Test](https://github.com/elastest/demo-projects/tree/master/rest-java-test):

<div class="row">
<div class="col-md-6">
<h4>REST Controller to test</h4>
<pre>
<code class="java">
@SpringBootApplication
@RestController
public class RestApp {

    @GetMapping("/")
    String home() {
        return "Hello World!";
    }

    public static void main(String[] args) 
    throws Exception {
        SpringApplication.run(RestApp.class, args);
    }
}
</code>
</pre>
<blockquote>Path "/" must return "Hello World!" on a GET request</blockquote>
</div>
<div class="col-md-6">
<h4>E2E test</h4>
<pre>
<code class="java">
public class RestAppTest {

    @Test
    public void rootServiceTest() {

    	String appHost = System.getenv("ET_SUT_HOST");

    	if(appHost == null) {
    		appHost = "localhost";
    	}

    	RestTemplate client = new RestTemplate();

    	String result = client.getForObject(
            "http://" + appHost + ":8080/",
            String.class);

    	assertThat(result).isEqualTo("Hello World!");
    }

}
</code>

</pre>
<blockquote><code>ET_SUT_HOST</code> variable will be the IP of our SuT. ElasTest will automatically inject the right value (<code>localhost</code> if not defined)</blockquote>
</div>
</div>

<h4 class="holder-subtitle link-top">1. Get into the desired project</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_1.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_1.png"/></a>
</div>

<h4 class="holder-subtitle link-top">2. Create a SuT</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_2.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_2.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_3.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_3.png"/></a>
</div>

Complete the form fields:

*   **SuT Name**: name of the Sut (`Rest App`)
*   **SuT Description**: description of the SuT (`Rest App description`)
*   **With Commands Container** / **With Docker Image** / **With Docker Compose**: whether to deploy the SuT on ElasTest as _commands container_, as a Docker _image_ or a _docker-compose_ (`With Docker Image`)
*   **Docker Image**: image of the SuT (`elastest/demo-rest-java-test-sut`)
*   **Wait for http port**: which port of the SuT should ElasTest wait to be available before starting the TJob (`8080`)

<br>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_4.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_4.png"/></a>
</div>
<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i> You can read <a href="/docs/deploying/aws"> Software under Test </a> if you need help with the SuT.</i></p></div>
</div>

<h4 class="holder-subtitle link-top">3. Create a new TJob</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_5.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_5.png"/></a>
</div>

Complete the form fields:

*   **TJob Name**: name of the TJob
*   **Select a SuT**: already created SuT to be tested through to the TJob (`Rest App`)
*   **Environment docker image**: the docker image that will host your test. This docker images should contain a client to download your code from your repository hosting service. For example, if your tests are hosted in GitHub and implemented in a Maven project with Java, you need to include a git client, Maven and the Java Development Kit (JDK) in the image. Indeed, this image contains Git, Maven and Java (`elastest/test-etm-alpinegitjava`)
    <!-- Modify when all images are available for testing with different hostsing services and technologies: Java, Maven, Pyhton, Ruby, Node... -->
*   **Commands**: these are the bash commands to be executed to download the code from a repository and to execute the tests. The specific commands depends on the source code repository type and the technology. For example, the following commands will clone a Maven/Java repository from GitHub and execute the tests:

          git clone https://github.com/elastest/demo-projects
          cd demo-projects/rest-java-test
          mvn test

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_6.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_6.png"/></a>
</div>

<h4 class="holder-subtitle link-top">4. Run the TJob from the Project's page</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_7.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_7.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_8.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_8.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/e2e_test_9.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e_test_9.png"/></a>
</div>

In this example, when the TJob is executed, the following steps are performed:

<ol class="ordered-list">
<li>SuT is executed starting the docker container <code>elastest/demo-rest-java-test-sut</code></li>
<li>ElasTest waits until container has a http service available in port <code>8080</code></li>
<li>When service is ready, the test container <code>elastest/test-etm-alpinegitjava</code> is started and specified commands are executed on it.</li>
<li>The test implemented in <code>demo-projects/rest-java-test</code> maven project is executed. This test makes a http request to a REST endpoint in the SuT and verifies that current result is the expected one.</li>
<li>When the test container finishes, ElasTest stops the SuT and TJob containers</li>
</ol>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-5" href="/docs/testing/images/e2e-rest-flow.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/e2e-rest-flow.png"/></a>
</div>

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
