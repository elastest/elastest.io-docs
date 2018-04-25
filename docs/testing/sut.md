<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Software under Test</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

ElasTest supports two deployment modes of SuT:

- **SuT deployed by ElasTest**: your software is packaged as Docker container/s. It can be a single Docker image or a docker-compose.
- **SuT outside ElasTest**: your software is already deployed somewhere.

When creating a new SuT you are able to defined what mode of deployment ElasTest should work with.

<h4 class="holder-subtitle link-top">SuT deployed by ElasTest</h4>

<h6 class="small-subtitle">With Commands Container</h6>

Your SuT is packaged as a Docker image. You must write the *Commands Container Image* and the commands below. These commands will run like the docker image CMD.

Fields to declare:

- **Commands container images**: name of the container image
- **Commands**: commands to execute
- **Wait for http port**: port that ElasTest should wait for to be available before running your TJobs

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/docker_image.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/commands_container.png"/></a>
</div>

<h6 class="small-subtitle">With Docker image</h6>

Your SuT is packaged as a Docker image. ElasTest will pull it from DockerHub and run it as the `Dockerfile` states.

Fields to declare:

- **Docker image**: name of the image (tagged or untagged)
- **Wait for http port**: port that ElasTest should wait for to be available before running your TJobs

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/docker_image.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/docker_image.png"/></a>
</div>

<h6 class="small-subtitle">With docker-compose</h6>

Your SuT is declared as a docker-compose. ElasTest will pull all the necessary images from DockerHub and run them as the field _Docker Compose_ states

Fields to declare:

- **Docker Compose**: your `docker-compose.yml` file. Simply copy-paste its content here
- **Main Service Name**: the name of the service that ElasTest should wait for to be up before running your TJobs (the specific port is declared in the next field _Wait for http port_)
- **Wait for http port**: port that ElasTest should wait for to be available before running your TJobs (applied to the service declared in the previous field _Main Service Name_)

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/docker_compose.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/docker_compose.png"/></a>
</div>

<h4 class="holder-subtitle link-top">SuT outside ElasTest</h4>

<h6 class="small-subtitle">No instrumentation</h6>

Your SuT is already deployed on an external server and you don't want to send any logs or metrics to ElasTest.

Fields to declare:

- **SuT IP**: IP or DNS of your SuT. Thanks to this field your TJobs may know how to reach your SuT through environment variable `ET_SUT_HOST`. Check [Environment variables](/testing/environment-variables) to learn more.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/no_instrumentation.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/no_instrumentation.png"/></a>
</div>

<h6 class="small-subtitle">Manual instrumentation</h6>

Your SuT is already deployed on an external server and you want to manually send its logs and metrics to ElasTest.

Fields to declare:

- **SuT IP**: IP or DNS of your SuT. Thanks to this field your TJobs may know how to reach your SuT through environment variable `ET_SUT_HOST`. Check [Environment variables](/testing/environment-variables) to learn more.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/manual_instrumentation.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/manual_instrumentation.png"/></a>
</div>

After filling SuT name and description fields, click on _Save and get monitoring details_ button to get all the necessary fields to manually instrument your server following [these instructions]().

<h6 class="small-subtitle">Automatic instrumentation</h6>

Your SuT is already deployed on an external server and you want to automatically send its logs and metrics to ElasTest.

***(Coming soon)***

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