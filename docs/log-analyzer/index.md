<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Log Analyzer</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/log-analyzer/images/log-analizer1.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/log-analizer1.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/log-analyzer/images/log-analizer2.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/log-analizer2.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/log-analyzer/images/log-analizer3.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/log-analizer3.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/log-analyzer/images/log-analizer4.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/log-analizer4.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/log-analyzer/images/log-analizer5.png"><img class="img-responsive img-wellcome" src="/docs/log-analyzer/images/log-analizer5.png"/></a>
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