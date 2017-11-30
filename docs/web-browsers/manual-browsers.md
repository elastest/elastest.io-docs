<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Launching Web Browsers on ElasTest</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<p>
ElasTest Web Browser service allows you to launch any browser and version you want directly from its dashboard, so you can <strong>manually test your web application's behaviour on any browser from any browser</strong>. If you want to let ElasTest launch the browsers itself, check section <a href="/docs/web-browsers/outside-testing/">Testing with Web Browsers from outside ElasTest</a>.
</p>

<p>
To launch a browser from ElasTest dashboard (<i>Web Browsers</i> page), select the desired browser and version and launch it:
</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/images/test.png"><img class="img-responsive img-wellcome" src="/docs/images/test.png"/></a>
</div>

<p>
Now the selected browser will be downloaded (it will take some time only for the first time you run certain version). Once it is up and running, you can click on "View" button inside "Web Browsers" card in order to see the browser as any end user would on their own computer. You can also interact directly with it.
</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/images/test.png"><img class="img-responsive img-wellcome" src="/docs/images/test.png"/></a>
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