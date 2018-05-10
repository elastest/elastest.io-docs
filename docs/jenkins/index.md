<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Jenkins integration</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<img style="border: none; margin: auto" class="img-responsive img-wellcome" src="/docs/jenkins/images/elastest_jenkins.png"/>

ElasTest provides a Jenkins plugin for you to use the platform in your CI environment. Thanks to this you can make use of some features provided by ElasTest, such as log analysis or the use of on-demand browsers. Before you can use ElasTest as Jenkins plugin you need to install the plugin and complete its onfiguration. After this you will be ready to use ElasTest in a Free Style Job or in a Pipeline Job.

<h4 class="holder-subtitle link-top">Plugin installation</h4>

To install the ElasTest Plugin you should follow this steps:

*   Go to your Jenkins installation and click in **Manage Jenkins / Manage Plugins**.
*   The next step is to open the **Available** tab and search "elastest". The ElasTest plugin will appear and you will check the box and click the "Install plugin" button.

<p></p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/jenkins/images/plugin_install.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/plugin_install.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Plugin configuration</h4>

The plugin configuration is very simple and you only have to fill in the following fields:

*   **ElasTest URL**: complete URL of ElasTest (including protocol and port)
*   **Username**: ElasTest username (configured on ElasTest launch)
*   **Password**: ElasTest password (configured on ElasTest launch)

<br>
Before you execute your first Job integrated with ElasTest, you can check if the connection between Jenkins and ElasTest is successfully established.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/jenkins/images/conf.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/conf.png"/></a>
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
