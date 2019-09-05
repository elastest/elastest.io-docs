<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Using Jenkins</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Installation</h4>

<img style="border: none; margin: auto" class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/elastest_jenkins.png"/>

To ease the integration of ElasTest in Continuous Integration environments, a plugin has been created for the most widespread open source CI server, Jenkins. Thanks to this plugin you will be able to make use of the functionalities provided by ElasTest from any Freestyle or Pipeline project.

To start trying ElasTest from Jenkins, you can choose one of these two options:

*   **Use the Jenkins integrated in ElasTest**. ElasTest provides an already integrated Jenkins server ready to use. This means that it is not necessary to install the ElasTest plugin (it is already installed) or perform any other configuration.You can start the integrated Jenkis in two ways:
    *   Start Jenkins with ElasTest: just add the option [[--jenkins|-jk]](/try-elastest) to the start command of ElasTest.
    *   Start Jenkins from ElasTest GUI: can also be started from the ElasTest GUI once it has been started (this is explained on the [next page](/jenkins/try-jenkins)).
*   **Integrate your own Jenkins with ElasTest**. If you alredy have a Jekins as a CI server, before you can use ElasTest as Jenkins plugin you need to install the plugin and complete its configuration. This proccess is described below.


<h4 class="small-subtitle">Plugin installation</h4>
To install the ElasTest Plugin you should follow this steps:

*   Navigate through **Manage Jenkins / Manage Plugins**.
*   The next step is to open the **Available** tab and search **elastest**. The ElasTest plugin will appear and you will check the box and click the **Install plugin** button.

<p></p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/integration/plugin_install.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/plugin_install.png"/></a>
</div>

<h4 class="small-subtitle">Plugin configuration</h4>

The plugin configuration is very simple and you only have to fill in the following fields:

*   **ElasTest URL**: complete URL of ElasTest (including protocol and port)
*   **Username**: ElasTest username (configured on ElasTest launch)
*   **Password**: ElasTest password (configured on ElasTest launch)

<br>
Before you execute your first Job integrated with ElasTest, you can check if the connection between Jenkins and ElasTest is successfully established.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/integration/conf.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/conf.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Using Jenkins integrated in ElasTest</h4>

Once started ElasTest, you can make use of the Jenkins instance provided, which contains some example jobs loaded by default.

If you did not start ElasTest with the **`--jenkins`** parameter (see how to [start ElasTest](/try-elastest) and its parameters), the Jenkins instance will not be available but you can start it manually from the ElasTest GUI navigating to the **`Jenkins`** section and clicking on the **`Start Jenkins`** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_not_started_marked.png"/></a>
</div>

Jenkins start progress will be shown:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_section_starting.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_section_starting.png"/></a>
</div>

Once started, a button to open Jenkins in a new browser tab and another button to show the access credentials will be shown (If you started Jenkins with ElasTest --jenkins parameter, these buttons will be displayed directly)

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/jenkins/images/try/jenkins_started_marked.png"><img class="img-responsive img-wellcome" src="/docs/jenkins/images/try/jenkins_started_marked.png"/></a>
</div>