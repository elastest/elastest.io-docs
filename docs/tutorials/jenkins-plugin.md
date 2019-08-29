<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Jenkins plugin</h2>
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
*   **Integrate your own Jenkins with ElasTest**. If you alredy have a Jekins as a CI server, before you can use ElasTest as Jenkins plugin you need to install the plugin and complete its onfiguration. This proccess is described below.


<h4 class="small-subtitle">Plugin installation</h4>
To install the ElasTest Plugin you should follow this steps:

*   Navigate through **Manage Jenkins / Manage Plugins**.
*   The next step is to open the **Available** tab and search **elastest**. The ElasTest plugin will appear and you will check the box and click the **Install plugin** button.

<p></p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/tutorials/images/jenkins/integration/plugin_install.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/plugin_install.png"/></a>
</div>

<h4 class="small-subtitle">Plugin configuration</h4>

The plugin configuration is very simple and you only have to fill in the following fields:

*   **ElasTest URL**: complete URL of ElasTest (including protocol and port)
*   **Username**: ElasTest username (configured on ElasTest launch)
*   **Password**: ElasTest password (configured on ElasTest launch)

<br>
Before you execute your first Job integrated with ElasTest, you can check if the connection between Jenkins and ElasTest is successfully established.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-3" href="/docs/tutorials/images/jenkins/integration/conf.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/integration/conf.png"/></a>
</div>

<h4 class="holder-subtitle link-top">Usage</h4>

<h4 class="small-subtitle">Elastest pipeline</h4>

To run our tests using Jenkins in Elastest, first open the Jenkins and click in **`new task`**

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/pipeline/new-item.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/new-item.png"/></a>
</div>

Writte the name of the item: **`AMICourses`** and select **`Pipeline`**

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/pipeline/item-name.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/item-name.png"/></a>
</div>

Now we will write the Pipeline: 

*   The application we will use is [AMICOurses](https://github.com/elastest-experiments/webapp-2.git).
*   The test we will launch is [Test](https://github.com/elastest-experiments/webapp-2/blob/master/AMICOServer/src/test/java/com/example/demo/e2e/api/TestAPIRestTemplate.java), this tests check that the not logged user don't see sensible information.

The application contains a bug with the objective of the show the logs and compare the good execution with the bug execution. Finally the **`Pipeline`** that we will use is:

```groovy
node{
    def sutIp
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage("Setting environment") {
            echo 'Environment variables'
            sh "env"
            git "https://github.com/elastest-experiments/webapp-2.git"
        }
        try {
            stage("Start Sut") {
                sh "cd docker-compose; export AMICO_IMAGE=webapp-2-fixed-profile; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
                sutContainerName = env.ET_SUT_CONTAINER_NAME + "_webapp2_1";
                sutNetwork = getFirstNetwork(sutContainerName)
                sutIp = containerIp(sutContainerName,network)

                echo 'Sut ip: '+ sutIp
                sh 'docker run -e IP=' + sutIp + ' -e PORT=8000 --network=' + sutNetwork + ' elastest/etm-check-service-up'
            }
            stage("Run Tests") {
                withEnv(['ET_SUT_HOST=' + sutIp, 'ET_SUT_PORT=8000']) {
                    echo 'Running test'
                    mvnHome = tool 'M3.3.9'
                    sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
                    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                }
            }
        } finally {
                echo 'Stopping SUT'
                sh "cd docker; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
        }
    }
}


def getFirstNetwork(containerName) {
    echo "Inside getFirstNetwork function"
    network = sh (
        script: "docker inspect " + containerName + " -f \"{{json .NetworkSettings.Networks}}\" | awk \"{sub(/:.*/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/{/,\\\"\\\")}1\"",
        returnStdout: true
    ).trim()
    
    echo containerName+" Network = " + network;
    return network;
}

def containerIp(containerName, network) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{{.NetworkSettings.Networks." + network + ".IPAddress}}\" "+ containerName,
        returnStdout: true
    ).trim()
    
    echo containerName+" IP = " + containerIp;
    return containerIp;
}
```

The example above can be split into the following sections:

-   **ElasTest plugin block with configuration** : this block will contain all the steps that the test must follow, as well as the necessary [configuration options](#options).

<p></p>

```groovy
node{
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        .......
    }
}
```

<p></p>

-   **Sut configuration** : The SUT must be started, passing the **`${env.ET_SUT_CONTAINER_NAME}`** env variable (provided by ElasTest) as name of the container. This will allow ElasTest to receive logs and metrics from the Sut.

<p></p>

```groovy
sh "cd docker-compose; export AMICO_IMAGE=webapp-2-fixed-profile; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
sutContainerName = env.ET_SUT_CONTAINER_NAME + "_webapp2_1";
sutNetwork = getFirstNetwork(sutContainerName)
sutIp = containerIp(sutContainerName,network)
```

<p></p>

-   **Wait for Sut** : You have to obtain the Sut network and ip and run check image (elastest/etm-check-service-up) provided by ElasTest to wait for the Sut to be ready to be used. This step is not required, you can wait in other ways or not do it, but for this example we do it.
    <p></p>

```groovy
echo 'Sut ip: '+ sutIp
sh 'docker run -e IP=' + sutIp + ' -e PORT=8000 --network=' + sutNetwork + ' elastest/etm-check-service-up'
```

<p></p>

-   **Test Execution** : Finally, the tests should be executed to verify that the SUT is working correctly. Remember that you have to configure the Sut ip as an environment variable or pass it as a maven property so that the test knows where the SUT is.

<p></p>

```groovy
stage("Run Tests") {
    withEnv(['ET_SUT_HOST=' + sutIp, 'ET_SUT_PORT=8000']) {
        echo 'Running test'
        mvnHome = tool 'M3.3.9'
        sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
        step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
    }
}
```

<p></p>

-   **Stop Sut** : The SUT will stop when the test is finished, passing the **`${env.ET_SUT_CONTAINER_NAME}`** env variable (provided by ElasTest) as name of the container.

<p></p>

```groovy
} finally {
        echo 'Stopping SUT'
        sh "cd docker; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
}
```

<p></p>

Copy the **`Pipeline`** and paste in the **Pipeline** section, as follows:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/pipeline/pipeline.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/pipeline.png"/></a>
</div>

When the Job is created, we will click in **`Build Now`** button:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/pipeline/run-tjob.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/run-tjob.png"/></a>
</div>

After pressing the button, you will see the job running on Jenkins:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/pipeline/running-tjob.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/running-tjob.png"/></a>
</div>

Entering the build page, you will see the Open in ElasTest button, where you can see the execution page in ElasTest (If the button does not appear refresh the page, it may take a while). ElasTest will have created a project called **`Jenkins Examples`** also you show the project in this section.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/pipeline/open-in-elastest.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/open-in-elastest.png"/></a>
</div>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/pipeline/execution.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/pipeline/execution.png"/></a>
</div>

<h4 class="small-subtitle">Collecting logs & metrics automatically</h4>

ElasTest collect logs and metrics automatically this will show in the section **`TJob Monitoring`** of the **`TJob`**. There logs may download if click in the button marked.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/logs/tjob-monitoring.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/tjob-monitoring.png"/></a>
</div>

<h4 class="small-subtitle">Observing sut & test behaviour in elastest</h4>

In the **TJob** we will observe the logs of the sut or test selecting the **sut** or **test** like we show in the following image:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/logs/sut-logs.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/sut-logs.png"/></a>
</div>

<h4 class="small-subtitle">Comparing executions (logs & metrics)</h4>

ElasTest allows compare two different executions, we will may the logs and metric comparative. We relaunch the Jenkins Job, but with a small changed. This changed makes the execution correct. 

Change `export AMICO_IMAGE=webapp-2-fixed-profile;` for `AMICO_IMAGE=webapp-2-master;` in the **`Pipeline`**. The final result show in the folloging box:

```groovy
node{
    def sutIp
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage("Setting environment") {
            echo 'Environment variables'
            sh "env"
            git "https://github.com/elastest-experiments/webapp-2.git"
        }
        try {
            stage("Start Sut") {
                sh "cd docker-compose; export AMICO_IMAGE=webapp-2-master; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} up -d"
                sutContainerName = env.ET_SUT_CONTAINER_NAME + "_webapp2_1";
                sutNetwork = getFirstNetwork(sutContainerName)
                sutIp = containerIp(sutContainerName,network)

                echo 'Sut ip: '+ sutIp
                sh 'docker run -e IP=' + sutIp + ' -e PORT=8000 --network=' + sutNetwork + ' elastest/etm-check-service-up'
            }
            stage("Run Tests") {
                withEnv(['ET_SUT_HOST=' + sutIp, 'ET_SUT_PORT=8000']) {
                    echo 'Running test'
                    mvnHome = tool 'M3.3.9'
                    sh "cd AMICOServer; '${mvnHome}/bin/mvn' -Dtest=TestAPIRestTemplate -B test"
                    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                }
            }
        } finally {
                echo 'Stopping SUT'
                sh "cd docker; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
        }
    }
}


def getFirstNetwork(containerName) {
    echo "Inside getFirstNetwork function"
    network = sh (
        script: "docker inspect " + containerName + " -f \"{{json .NetworkSettings.Networks}}\" | awk \"{sub(/:.*/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/{/,\\\"\\\")}1\"",
        returnStdout: true
    ).trim()
    
    echo containerName+" Network = " + network;
    return network;
}

def containerIp(containerName, network) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{{.NetworkSettings.Networks." + network + ".IPAddress}}\" "+ containerName,
        returnStdout: true
    ).trim()
    
    echo containerName+" IP = " + containerIp;
    return containerIp;
}
```

When we changed it, we will relaunch the job. And we will see:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/logs/jenkis-job.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/jenkis-job.png"/></a>
</div>

Now we will go to the **`AMICourses`** TJob in elastest and select the two executions from the table and finally press the **Compare Executions** button.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/logs/select-tjobs-for-comparing.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/select-tjobs-for-comparing.png"/></a>
</div>

Once added you will see the following card, in this card we will see the metric comparisons and we will select the **test_default_log** and click the **** button for the show the comparison logs.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/logs/compare-metrics-select-comparison.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/compare-metrics-select-comparison.png"/></a>
</div>

When push the button we will show the comparative betwen th two executions. In this case we will check that the left log return a 401 error nevertheless the right log return some information in JSON format. The test check that the not logged person no see the information that not correspond them. Therefore we check that the error is because the application return sensible information when not logged user.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/jenkins/logs/compare-error.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/jenkins/logs/compare-error.png"/></a>
</div>