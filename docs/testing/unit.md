<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Running unit tests</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<div class="badges-menu">
    <span class="badge badge-default my-badge selected">Java</span>
    <span class="badge badge-default my-badge my-badge-disabled">Node</span>
    <span class="badge badge-default my-badge my-badge-disabled">Python</span>
    <span class="badge badge-default my-badge my-badge-disabled">. . .</span>
</div>

Running unit and integration tests with ElasTest doesn't require launching beforehand a [SuT](/fundamentals/core-concepts/). The test itself will manage the execution of the tested software. So the only requirment is to create a TJob and launch it. Here we will run our [Unit Java Test](https://github.com/elastest/demo-projects/tree/master/unit-java-test):

<div class="row">
<div class="col-md-6">
<h4>Class to test</h4>
<pre>
<code class="java">
public class Calc {

    public int sum(int a, int b) {
        return a + b;
    }

}
</code>
</pre>

</div>
<div class="col-md-6">
<h4>Unit test</h4>
<pre>
<code class="java">
public class CalcTest {

    private Calc calc;

    @BeforeEach
    public void init() {
        this.calc = new Calc();
    }

    @Test
    public void sumTest() {
        assertThat(calc.sum(3,2)).isEqualTo(5);
    }

}
</code>
</pre>
</div>
</div>

<h4 class="holder-subtitle link-top">1. Get into the desired project</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_1.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_1.png"/></a>
</div>

<h4 class="holder-subtitle link-top">2. Create a new TJob</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_2.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_2.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_3.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_3.png"/></a>
</div>

When a TJob is created, the minimum information that you have to provide is the following:

- **TJob Name**: name of the TJob
- **Select a SuT**: `None`
- **Environment docker image**: the docker image that will host your test. This docker images should contain a client to download your code from your repository hosting service. For example, if your tests are hosted in GitHub and implemented in a Maven project with Java, you need to include a git client, Maven and the Java Development Kit (JDK) in the image. Indeed, the image `elastest/test-etm-alpinegitjava` contains Git, Maven and Java.
<!-- Modify when all images are available for testing with different hostsing services and technologies: Java, Maven, Pyhton, Ruby, Node... -->
- **Commands**: these are the bash commands to be executed to download the code from a repository and to execute the tests. The specific commands depends on the source code repository type and the technology. For example, the following commands will clone a Maven/Java repository from GitHub and execute the tests:

        git clone https://github.com/elastest/demo-projects
        cd demo-projects/unit-java-test
        mvn test


<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_4.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_4.png"/></a>
</div>

<h4 class="holder-subtitle link-top">3. Run the TJob from the Project's page</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_5.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_5.png"/></a>
</div>

Immediately after, the execution view will open automatically. You will see your logs and metrics in real time.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_6.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_6.png"/></a>
</div>

<h4 class="holder-subtitle link-top">4. Check the final result of your TJob</h4>

Your test will finish at some point: you can see the final entries in the "Test Logs" card and the TJob status changing to ***SUCCESS***, ***FAIL***, ***STOPPED*** or ***ERROR*** depending on the final result.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_7.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_7.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/testing/images/unit_test_8.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/unit_test_8.png"/></a>
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