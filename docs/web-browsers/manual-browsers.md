<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Launching Web Browsers on ElasTest</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<p>
ElasTest Web Browser service allows you to launch any browser and version you want directly from its dashboard, so you can <strong>manually test your web application's behaviour on any browser from any browser</strong>. If you want to let ElasTest launch the browsers itself, check section <a href="/docs/web-browsers/outside-testing/">Testing with Web Browsers from outside ElasTest</a>.
</p>

<p>
Currently the following browsers and versions are supported:
</p>

|Browser|Versions|
|-------|-------|
|Chrome|beta, unstable, latest, from 60.0 onwards|
|Firefox|beta, nightly, latest, from 57.0 onwards|
|Edge|_Coming soon_|

**beta** : _The last beta version_. <br>
**unstable** : _The development version_.<br>
**latest** : _The last stable version_.<br>
**nightly** : _The development version_.

<p>
To launch a browser from ElasTest dashboard (<i>Web Browsers</i> page), select the desired browser and version and launch it:
</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/web-browsers/images/manual/launch_chrome.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/manual/launch_chrome.png"/></a>
</div>

Now the selected browser will be launched (it will take some time only for the first time you run a non-latest version, as it needs to be downloaded).

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/web-browsers/images/manual/loading.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/manual/loading.png"/></a>
    <a data-fancybox="gallery-1" href="/docs/web-browsers/images/manual/loaded.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/manual/loaded.png"/></a>
</div>

You can see the browser as any end user would on their own computer, and also interact directly with it: resize it, navigate to any URL ...

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/web-browsers/images/manual/elastest.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/manual/elastest.png"/></a>
</div>

Finally, whenever you close the browser (bottom-left "Close" button), after a few seconds (depending on how long the live session lasts) you will have available on "Recordings" card an _.mp4_ file ready to be downloaded with your recorded browser session.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/web-browsers/images/manual/recordings.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/manual/recordings.png"/></a>
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