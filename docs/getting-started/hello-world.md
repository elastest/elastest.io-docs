<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Hello world</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

ElasTest will launch with one sample project included so users can quickly run their first test. To do so:

<h2 class="h4 no-border">1. Access your ElasTest dashboard</h2>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/getting-started/images/dashboard.png"><img class="img-responsive img-wellcome" src="/docs/getting-started/images/dashboard.png"/></a>
</div>

<h2 class="h4 no-border">2. Get into "Hello world" project</h2>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/getting-started/images/project_selection.png"><img class="img-responsive img-wellcome" src="/docs/getting-started/images/project_selection.png"/></a>
</div>

<h2 class="h4 no-border">3. Run the only TJob available for the project</h2>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/getting-started/images/run_tjob.png"><img class="img-responsive img-wellcome" src="/docs/getting-started/images/run_tjob.png"/></a>
</div>

<h2 class="h4 no-border">4. Execution screen is open automatically</h2>

<p>Our TJob will start running: you will see CPU metric on the chart and the Test log. Eventually the test should end succesfully.</p>

<div class="docs-gallery row">
    <div class="col-md-4">
        <a data-fancybox="gallery-4" href="/docs/getting-started/images/execution_start.png"><img class="img-responsive img-wellcome" src="/docs/getting-started/images/execution_start.png"/></a>
    </div>
    <div class="col-md-4">
        <a data-fancybox="gallery-4" href="/docs/getting-started/images/execution_running.png"><img class="img-responsive img-wellcome" src="/docs/getting-started/images/execution_running.png"/></a>
    </div>
    <div class="col-md-4">
        <a data-fancybox="gallery-4" href="/docs/getting-started/images/execution_finished.png"><img class="img-responsive img-wellcome" src="/docs/getting-started/images/execution_finished.png"/></a>
    </div>
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