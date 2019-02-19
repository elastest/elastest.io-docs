<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Testing with Web Browsers from outside ElasTest</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

You can make use of ElastTest Web Browser services to <strong>run your local or CI end-to-end tests on any browser and version</strong> you want.

This is a deal breaker for developers: whatever platform you are coding in and whatever framework you are using, you can easily launch any browser in ElasTest dashboard and use it remotely to run your tests straight from your machine, as you would do in your favourite IDE. Do you want to test your web on Microsoft's Edge but you don't even have a Windows machine? No problem, just launch an Edge instance on ElasTest and run your test against it. Any other browser provided in ElasTest Web Browser services could serve as an example of this use case.

In order to run your test on ElasTest browsers, you just need to use the **URL shown on "Web Browsers" page**. There are no restrictions on the environment your test is being executed: you can run it on your development machine from the command line or even directly from your favourite editor. Or you can run your test on ElasTest browsers as part of your CI platform, so that in the event of any failure you can check the window recording and browser's console. The advantages are considerable compared to other alternatives.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/web-browsers/images/remote_url.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/remote_url.png"/></a>
</div>

To illustrate this scenarios, let's see how to start a Selenium Web Driver using different languages to remotely use ElasTest browsers. If the URL provided in "Web Browsers" page is `https://MY_REMOTE_WEB_BROWSER_URL.com`:

<div class="badges-menu noselectionable">
    <span id="java-test-btn" class="badge badge-default my-badge selected">Java</span>
    <span id="js-test-btn" class="badge badge-default my-badge">JS</span>
    <span class="badge badge-default my-badge my-badge-disabled">. . .</span>
</div>

<div id="java-test" class="web-langs">
<pre><code class="java">// Chrome

DesiredCapabilities caps = new DesiredCapabilities().chrome();
caps.setCapability("live", true);
WebDriver driver = new RemoteWebDriver(new URL("https://MY_REMOTE_WEB_BROWSER_URL.com"), caps);

// Firefox

DesiredCapabilities caps = new DesiredCapabilities().firefox();
caps.setCapability("live", true);
WebDriver driver = new RemoteWebDriver(new URL("https://MY_REMOTE_WEB_BROWSER_URL.com"), caps);</code></pre>
</div>

<div id="js-test" class="web-langs" hidden>
<pre><code class="javascript">// Chrome

var browserBuilder = new webdriver.Builder().forBrowser("chrome");
browserBuilder.usingServer("https://MY_REMOTE_WEB_BROWSER_URL.com");
driver = browserBuilder.build();

// Firefox

var browserBuilder = new webdriver.Builder().forBrowser("firefox");
browserBuilder.usingServer("https://MY_REMOTE_WEB_BROWSER_URL.com");
driver = browserBuilder.build();</code></pre>
</div>

<p>
That's all the extra configuration needed. The rest of the code is exactly the same as in a regular Selenium test.
Whenever you run it, ElasTest will launch the requested browser on-demand and the test will be remotely executed against it.
</p>

<p>
You will have available the browser's window in real time to see your test in action. When it finishes, a <i>.mp4</i> file will be available for download.
</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-2" href="/docs/web-browsers/images/auto_chrome.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/auto_chrome.png"/></a>
    <a data-fancybox="gallery-2" href="/docs/web-browsers/images/auto_chrome_window.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/auto_chrome_window.png"/></a>
    <a data-fancybox="gallery-2" href="/docs/web-browsers/images/auto_recording.png"><img class="img-responsive img-wellcome" src="/docs/web-browsers/images/auto_recording.png"/></a>
</div>

<script>
$('#java-test-btn').click(function(event) {
  activateBadge('java-test');
});
$('#js-test-btn').click(function(event) {
  activateBadge('js-test');
});

function activateBadge(sectionName) {
  $('.web-langs').hide();
  $('#' + sectionName).show();
  $('.selected').removeClass('selected');
  $('#' + sectionName + '-btn').addClass('selected');
}
</script>
