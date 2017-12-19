<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Your first test with ElasTest</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

After [launching Elastest](/try-elastest), there will be a "Hello world" sample project available on the dashboard so users can quickly run their first test. To do so:

<h4 class="holder-subtitle link-top">1. Access your ElasTest dashboard</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/dashboard.png"><img class="img-responsive img-wellcome" src="/docs/images/dashboard.png"/></a>
</div>

<h4 class="holder-subtitle link-top">2. Get into "Hello world" project</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/project_selection.png"><img class="img-responsive img-wellcome" src="/docs/images/project_selection.png"/></a>
</div>

<h4 class="holder-subtitle link-top">3. Run the only TJob available for the project</h4>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/run_tjob.png"><img class="img-responsive img-wellcome" src="/docs/images/run_tjob.png"/></a>
</div>

<h4 class="holder-subtitle link-top">4. Execution screen is open automatically</h4>

<p>Our TJob will start running: you will see CPU metric on the chart and the Test log. Eventually the test should end succesfully.</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/images/execution_finished.png"><img class="img-responsive img-wellcome" src="/docs/images/execution_finished.png"/></a>
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
    loop: true,
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