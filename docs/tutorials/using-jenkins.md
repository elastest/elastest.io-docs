<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Using Jenkins</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Installation</h4>

<img style="border: none; margin: auto" class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/elastest_jenkins.png"/>

We want ElasTest to be a non-intrusive tool in your day-to-day activities. Therefore, we have created a plugin for the most widespread open source CI server: Jenkins. Thanks to this plugin you will be able to make use of the functionalities provided by ElasTest from any Freestyle or Pipeline project effortlessly. You'll see ElasTest provides value since the very beginning. However, to unveil its full potential, some help from your side is needed. Don't worry, this tutorial and the following ones will guide you through getting the most out of your testing activities in a stepwise way. 

To start trying ElasTest from Jenkins, you can choose one of these two options:

*   **Use the Jenkins server provided by ElasTest**. ElasTest already provides a Jenkins server ready to use as part of the ElasTest platform. This means that it is not necessary to install a dedicated Jenkins server and the corrsponding ElasTest Jenkins plugin on top of it, you can start playing with Jenkins and ElasTest without hassle. The integrated Jenkis server can be started in two ways:
    *   Start Jenkins with ElasTest: just add the option [[--jenkins|-jk]](/try-elastest) to the start command of ElasTest. See the link for further details. 
    *   Start Jenkins from ElasTest GUI: Jenkins can also be started from the ElasTest GUI once ElasTest has been started (this is explained on the [next page](/jenkins/try-jenkins)).
*   **Integrate your own Jenkins with ElasTest**. If you alredy have a Jekins server up and running, you can install the ElasTest Jenkins plugin, available from the plugin management page. This proccess is described below.


<h4 class="small-subtitle">Plugin installation</h4>
To install the ElasTest Jenkins plugin, follow this steps:

*   In your Jenkins server, logged as a user with administration privileges, navigate to **Manage Jenkins / Manage Plugins**.
*   Open the **Available** tab and search for **elastest**. The ElasTest Jenkins plugin will appear. Check the box and click the **Install plugin** button.

Keep reading to configure the plugin so that it can connect to your ElasTest installation.

<p></p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/integration/plugin_install.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/plugin_install.png"/></a>
</div>

<h4 class="small-subtitle">Plugin configuration</h4>

The plugin configuration is very simple and you only have to fill in the following fields:

*   **ElasTest URL**: complete URL of ElasTest (including protocol and port). This URL is provided by ElasTest automatically on startup. We have information on [configuring the ElasTest IP (and domain)](/try-elastest).
*   **Username**: ElasTest username (provided as a command on ElasTest startup)
*   **Password**: ElasTest password (provided as a command on ElasTest startup)

<br>
Before you execute your first Job integrated with ElasTest, we strongly recommend to check if the connection between Jenkins and ElasTest is successfully established by using the corresponding button on the configuration page.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/integration/conf.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/conf.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Using Jenkins integrated in ElasTest</h4>

The easiest way to have a look at what ElasTest can do for you and your tests is to make use of the Jenkins instance provided by the ElasTest platform, as it is populated with many example jobs by default.

If you did not start ElasTest with the **`--jenkins`** parameter (see how to [start ElasTest](/try-elastest) and its parameters), the Jenkins instance will not be running by default. However, you can start it manually from the ElasTest GUI navigating to the **`Jenkins`** section and clicking on the **`Start Jenkins`** button. 

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"/></a>
</div>

Jenkins start progress will be shown:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_starting.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_starting.png"/></a>
</div>

Once started, two buttons are displayed. One button to open Jenkins in a new browser tab, and another button to show the access credentials. If you started Jenkins with ElasTest --jenkins parameter, these buttons will be displayed directly, instead of the `Start Jenkins` button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_started_marked.png"/></a>
</div>