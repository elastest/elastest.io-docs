<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Running end to end tests: REST APIs</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<div class="badges-menu">
    <span class="badge badge-default my-badge">Java</span>
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

<h2 class="h4 no-border">1. Get into the desired project</h2>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/e2eRest1.png"><img class="img-responsive img-wellcome" src="/docs/images/e2eRest1.png"/></a>
</div>

<h2 class="h4 no-border">2. Create a SuT</h2>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/images/e2eRest2.png"><img class="img-responsive img-wellcome" src="/docs/images/e2eRest2.png"/></a>
    <a data-fancybox="gallery-2" href="/docs/images/e2eRest3.png"><img class="img-responsive img-wellcome" src="/docs/images/e2eRest3.png"/></a>
</div>

Right now all SuT's must be available as a Docker image or a docker-compose so ElasTest can deploy and monitor it automatically. Complete the form fields:

- **SuT Name**: name of the Sut (`Rest App`)
- **SuT Description**: description of the SuT (`Rest App description`)
- **With Docker Image** / **With Docker Compose**: whether to deploy the SuT on ElasTest as a Docker *image* or a *docker-compose* (`With Docker Image`)
- **Docker Image**: image of the SuT (`elastest/demo-rest-java-test-sut`)
- **Wait for http port**: which port of the SuT should ElasTest wait to be available before starting the TJob (`8080`)

<br>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/images/e2eRest4.png"><img class="img-responsive img-wellcome" src="/docs/images/e2eRest4.png"/></a>
</div>

<h2 class="h4 no-border">3. Create a new TJob</h2>

Complete the form fields:

- **TJob Name**: name of the TJob (`Rest test`)
- **Select a SuT**: already created SuT to be tested through to the TJob (`Rest App`)
- **Environment docker image**: the docker image that will host your test. This docker images should contain a client to download your code from your repository hosting service. For example, if your tests are hosted in GitHub and implemented in a Maven project with Java, you need to include a git client, Maven and the Java Development Kit (JDK) in the image. Indeed, this image contains Git, Maven and Java (`elastest/test-etm-alpinegitjava`)
<!-- Modify when all images are available for testing with different hostsing services and technologies: Java, Maven, Pyhton, Ruby, Node... -->
- **Commands**: these are the bash commands to be executed to download the code from a repository and to execute the tests. The specific commands depends on the source code repository type and the technology. For example, the following commands will clone a Maven/Java repository from GitHub and execute the tests:

        git clone https://github.com/elastest/demo-projects
        cd demo-projects/rest-java-test
        mvn test


<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/images/e2eRest5.png"><img class="img-responsive img-wellcome" src="/docs/images/e2eRest5.png"/></a>
</div>

<h2 class="h4 no-border">4. Run the TJob from the Project's page</h2>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/images/5.png"><img class="img-responsive img-wellcome" src="/docs/images/5.png"/></a>
    <a data-fancybox="gallery-4" href="/docs/images/e2eRest6.png"><img class="img-responsive img-wellcome" src="/docs/images/e2eRest6.png"/></a>
    <a data-fancybox="gallery-4" href="/docs/images/e2eRest7.png"><img class="img-responsive img-wellcome" src="/docs/images/e2eRest7.png"/></a>
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
    <a data-fancybox="gallery-5" href="/docs/images/e2e-flow.png"><img class="img-responsive img-wellcome" style="padding: 10px" src="/docs/images/e2e-flow.png"/></a>
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