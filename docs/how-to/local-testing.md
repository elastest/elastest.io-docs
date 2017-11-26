<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Local testing with ElasTest</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

You can make use of ElastTest Web Browser services to run your local end-to-end tests on any browser and version you want.

This is a deal breaker for developers: whatever platform you are coding in and whatever framework you are using, you can easily launch any browser in ElasTest dashboard and use it remotely to run your tests straight from your machine, as you would do in your favourite IDE. Do you want to test your web on Microsoft's Edge but you don't even have a Windows machine? No problem, just launch an Edge instance on ElasTest and run your test agains it. Any other browser provided in ElasTest Web Browser services could serve as an example of this use case.

To do so:

<h2 class="h4 no-border">1. Get into "Web Browsers" page</h2>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/how-to/images/e2eRest1.png"><img class="img-responsive img-wellcome" src="/docs/how-to/images/e2eRest1.png"/></a>
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