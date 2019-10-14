<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Getting started</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest can run in differents platforms like **Laptop**, **Linux VM** and **Server**. We use for this example the **Linux Laptop** deploy for wich need the following system specifications:

  <table>
    <tr>
      <td>Processor</td>
      <td>1GHz or faster</td>
    </tr>
    <tr><!--  -->
      <td>RAM</td>
      <td>16GB</td>
    </tr>
    <tr>
      <td>SWAP</td>
      <td>4GB (if RAM < 16GB)</td>
    </tr>
    <tr>
      <td>Hard Disk</td>
      <td>30GB</td>
    </tr>
  </table>
</div>

Once you have docker installed, execute the following command to start ElasTest:

<div class="row row-run-demo no-margin">
    <div class="col col-md-10 col-sm-8 col-xs-12">
        <div class="row no-margin">
            <div class="col-lg-1 col-md-2 col-sm-2 no-padding">
                <button id="btn-copy-2" class="btn btn-xs btn-primary" data-toggle="tooltip" data-placement="button"
                title="Copy to Clipboard">Copy</button>
            </div>
            <div class="col-lg-11 col-md-10 col-sm-10 no-padding">
                <code id="code-2"><strong>docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start</strong></code>
            </div>
        </div>
    </div>
</div>

If you need run ElasTest in other **Operating System**, **Virtual Machine** or in a **Server**, please visit the following [link](/try-elastest/).

#### Using Jenkins integrated in ElasTest

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

<h4 class="holder-subtitle link-top">Running the "JUnit5 Rest Test" TJob in Jenkins</h4>

There will be a **"jenkins-junit5-rest-test"** sample project available on the Jenkins integrated in ElasTest (among others) so users can quickly run their first test. To do so:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/jenkins-elastest-job.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/jenkins-elastest-job.png"/></a>
</div>

If you use the [Jenkins integrated in ElasTest](#using-jenkins-integrated-in-elastest), click in the **`jenkins-junit5-rest-test`** Job and go to the [4 STEP](#4-inside-pipeline-page), however if you don't use the integrated **Jenkins** following the next steps:

#### 1. Access your Jenkins
When you will open Jenkins click in the **`New Item`**

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/jenkins-new-item.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/jenkins-new-item.png"/></a>
</div>

#### 2. Define the name and type the Job 
Input the **`jenkins-junit5-rest-test`** and select the **`Pipeline`** option them click in the **`Ok`** button:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/jenkins-enter-item-name.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/jenkins-enter-item-name.png"/></a>
</div>

#### 3. You add the **Pipeline** 
In the following section we will see the **`Pipeline`** with ElasTest and without **`ElasTest`** and compare them.


##### Normal Pipeline (Without ElasTest)

```groovy
node{   
    stage ('Executing Test') {
        docker.image('elastest/demo-rest-java-test-sut').withRun('-p 8080:8080') { c -> 
            echo 'Set up test environment'
            mvnHome = tool 'M3.3.9'
            echo 'Cloning repository'
            git 'https://github.com/elastest/demo-projects'
            echo 'Run test'
            sh "cd ./rest/junit5-rest-test;'${mvnHome}/bin/mvn' -B test"
        }
    }
}
```

The example above can be split into the following sections:

<p></p>

-   **Start SUT** : This block started the SUT application.

<p></p>

```groovy
...
docker.image('elastest/demo-rest-java-test-sut').withRun('-p 8080:8080') { c -> 
...
```

<p></p>

-   **Run Test** : The tests execute if the SUT working correctly.

<p></p>

```groovy
...
echo 'Set up test environment'
mvnHome = tool 'M3.3.9'
echo 'Cloning repository'
git 'https://github.com/elastest/demo-projects'
echo 'Run test'
sh "cd ./rest/junit5-rest-test;'${mvnHome}/bin/mvn' -B test"
...
```

##### ElasTest Pipeline

```groovy
node{
    elastest(surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true, project: 'Jenkins Examples') {
        stage ('Executing Test') {
            echo 'Print env variables'
            sh 'env'
            def sutImage = docker.image('elastest/demo-rest-java-test-sut')
            echo 'Start SUT'
            def sutContainerName = env.ET_SUT_CONTAINER_NAME;
            sutImage.withRun("--name ${sutContainerName} --network=elastest_elastest") { c ->
                echo "${c.id}"
                def sutNetwork = getFirstNetwork(sutContainerName)
                def sutIp = containerIp(sutContainerName,sutNetwork)
                sh 'docker run -e IP=' + sutIp + ' -e PORT=8080 --network=' + sutNetwork + ' elastest/etm-check-service-up'
                withEnv(['ET_SUT_HOST=' + sutIp]) {
                    echo 'Set up test environment'
                    mvnHome = tool 'M3.3.9'
                    echo 'Cloning repository'
                    git 'https://github.com/elastest/demo-projects'
                    echo 'Run test'
                    sh "cd ./rest/junit5-rest-test;'${mvnHome}/bin/mvn' -B -DforkCount=0 test"
                }
            }
            
        }        
    }
}

def getFirstNetwork(containerName) {
    echo "Inside getFirstNetwork function"
    network = sh (
        script: "docker inspect " + containerName + " -f \"{%raw%}{{json .NetworkSettings.Networks}}{%endraw%}\" | awk \"{sub(/:.*/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/{/,\\\"\\\")}1\"",
        returnStdout: true
    ).trim()
    
    echo containerName+" Network = " + network;
    return network;
}

def containerIp(containerName, network) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{%raw%}{{.NetworkSettings.Networks." + network + ".IPAddress}}{%endraw%}\" "+ containerName,
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
...
def sutImage = docker.image('elastest/demo-rest-java-test-sut')
echo 'Start SUT'
def sutContainerName = env.ET_SUT_CONTAINER_NAME;
sutImage.withRun("--name ${sutContainerName} --network=elastest_elastest") { c ->
...
```

<p></p>

-   **Wait for Sut** : You have to obtain the Sut network and ip and run check image (elastest/etm-check-service-up) provided by ElasTest to wait for the Sut to be ready to be used. This step is not required, you can wait in other ways or not do it, but for this example we do it.

<p></p>

```groovy
echo 'Sut ip: '+ sutIp
sh 'docker run -e IP=' + sutIp + ' -e PORT=8000 --network=' + sutNetwork + ' elastest/etm-check-service-up'
```

We need added the following code in the **`Pipeline`**:

```groovy
def getFirstNetwork(containerName) {
    echo "Inside getFirstNetwork function"
    network = sh (
        script: "docker inspect " + containerName + " -f \"{%raw%}{{json .NetworkSettings.Networks}}{%endraw%}\" | awk \"{sub(/:.*/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/\\\"/,\\\"\\\")}1\" | awk \"{sub(/{/,\\\"\\\")}1\"",
        returnStdout: true
    ).trim()
    
    echo containerName+" Network = " + network;
    return network;
}

def containerIp(containerName, network) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{%raw%}{{.NetworkSettings.Networks." + network + ".IPAddress}}{%endraw%}\" "+ containerName,
        returnStdout: true
    ).trim()
    
    echo containerName+" IP = " + containerIp;
    return containerIp;
}
```

This code obtain the network and the ip of the **`SUT`** container this information is needed for wait the **`SUT`** is ready to launch the Tests.

<p></p>

-   **Test Execution** : Finally, the tests should be executed to verify that the SUT is working correctly. Remember that you have to configure the Sut ip as an environment variable or pass it as a maven property so that the test knows where the SUT is.

<p></p>

```groovy
withEnv(['ET_SUT_HOST=' + sutIp]) {
    echo 'Set up test environment'
    mvnHome = tool 'M3.3.9'
    echo 'Cloning repository'
    git 'https://github.com/elastest/demo-projects'
    echo 'Run test'
    sh "cd ./rest/junit5-rest-test;'${mvnHome}/bin/mvn' -B -DforkCount=0 test"
}
```

<p></p>

Copy the [ElasTest Pipeline](#elastest-pipeline) and paste it in the **Pipeline** section, as follows:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/jenkins-add-pipeline.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/jenkins-add-pipeline.png"/></a>
</div>

#### 4. Inside Pipeline page
When we inside into the Pipeline page we will click in the **`Build Now`** to launch the Job in ElasTest

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/jenkins-build-now.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/jenkins-build-now.png"/></a>
</div>

#### 5. Go to the TJob execution screen

Entering the build page, you will see the Open in ElasTest button, where you can see the execution page in ElasTest (If the button does not appear refresh the page, it may take a while).

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/jenkins-open-in-elastest.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/jenkins-open-in-elastest.png"/></a>
</div>

When the TJob was opened you will see the test information and logs:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/running.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/running.png"/></a>
</div>

<p>Once the test is finished you will see the test results and log. Eventually the test should end succesfully.</p>

<p>
    <div class="range range-xs range-xs-center warning-range">
        <div class="cell-xs-2 cell-lg-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
        <div class="cell-xs-10 cell-lg-11 warning-text"><p><i>IMPORTANT: ElasTest make use of  <a href="/docs/testing/unit#xmlAndtestResultsPath" title="View XML Report explanation">xml results file</a> to get all the test results information.</i></p></div>
    </div>
</p>

<p>You can also click on one of them to navigate to the information section of this Test Case, where you can see their logs filtered thanks to the two traces of logs that the class ElasTestBase prints at the beginning and end of each test and that we have commented above. There's only one in this TJob, so we'll navigate to this one (rootServiceTest):</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/results.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/results.png"/></a>
</div>

<p>If we would like see other logs we can select this logs in this section:</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/select-logs-to-show.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/select-logs-to-show.png"/></a>
</div>

#### 6. Show metrics

<p>We can show metrics of the test executions for different components. We select them in this button:</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/results-select-metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/results-select-metrics.png"/></a>
</div>

<p>We select the metrics that like view and push 'Apply and Save':</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/select-metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/select-metrics.png"/></a>
</div>

<p>We can see the selected metrics in the bottom of the page</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/metrics.png"/></a>
</div>