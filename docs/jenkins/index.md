<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Jenkins integration</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>The first stable version of ElasTest Jenkins plugin will be available very soon. Here is a brief preview of what it will look like. Stay tunned!</i></p></div>
</div>

<img style="border: none" class="img-responsive img-wellcome" src="/docs/jenkins/images/elastest_jenkins.png"/>

ElasTest provides a Jenkins plugin so you can use the platform in your CI environment. You can use it in a regular Job or in a Pipeline.

<h4 class="holder-subtitle link-top">Regular Job</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/job.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/job.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Pipeline</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/jenkins/images/pipeline.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/pipeline.png"/></a>
</div> 

<h4 class="holder-subtitle link-top">Plugin configuration</h4>

The plugin form only contains 3 fairly self-explanatory fields:

- **ElasTest URL**: complete URL of ElasTest (including protocol and port)
- **Username**: username set on ElasTest launch
- **Password**: password set on ElasTest launch

<br>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/jenkins/images/conf.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/conf.png"/></a>
</div> 

<h4 class="holder-subtitle link-top">Plugin features</h4>

With ElasTest Jenkins plugin you can integrate all the tools ElasTest offers into your Jenkins CI environment. Here you can see how the same logs are shown in Jenkins console and ElasTest:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-4" href="/docs/jenkins/images/jenkins_log.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/jenkins_log.png"/></a>
    <a data-fancybox="gallery-4" href="/docs/jenkins/images/elastest_log.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/elastest_log.png"/></a>
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