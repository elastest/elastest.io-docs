<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Advanced example</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Pipeline Job Examples</h4>

The installation of ElasTest, Jenkins and the collaboration between them, allows several configurations.

Bellow, you will find an example of pipeline where using the ElasTest plugin and implements severals configurations, a SUT is started and a test battery is executed on it.
To configure this option, ElasTest provides the connection info using [environment variables](/testing/environment-variables). This example is included in the Jenkins instance provided by ElasTest. If you use your own Jenkins, you will have to configure it manually in the following way:

<h5 class="small-subtitle">WebApp</h5>

This pipeline configures the ElasTes plugin, starts the SUT and clones the repository with the test to execute it.

```
node{
    elastest(tss: ['EUS'], surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', monitoring: true) {
        stage ('Executing Test') {
            echo 'Print env variables'
            sh 'env'
            def sutImage = docker.image('elastest/demo-web-java-test-sut')
            echo 'Start SUT'
            sutImage.withRun("--name ${env.ET_SUT_CONTAINER_NAME}") { c ->
                echo "${c.id}"
                def sutContainerName = env.ET_SUT_CONTAINER_NAME;
                def sutNetwork = getFirstNetwork(sutContainerName)
                def sutIp = containerIp(sutContainerName,network)
                sh 'docker run -e IP=' + sutIp + ' -e PORT=8080 --network=' + sutNetwork + ' elastest/etm-check-service-up'
                withEnv(['ET_SUT_HOST=' + sutIp]) {
                    echo 'Set up test environment'
                    mvnHome = tool 'M3.3.9'
                    echo 'Cloning repository'
                    git 'https://github.com/elastest/demo-projects'
                    echo 'Run test'
                    sh "cd ./web-java-test/;'${mvnHome}/bin/mvn' -Dtest=WebAppTest test"
                }
            }
            
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

*   **ElasTest plugin configuration** : You can choose to send the logs of your build

<p></p>

```
node{
    elastest() {
        .......
    {
```
<p></p>

*   **Sut configuration** : The SUT must be started, passing the `${env.ET_SUT_CONTAINER_NAME}` env variable (provided by ElasTest) as name of the container. This will allow ElasTest to receive logs and metrics from the Sut.
<p></p>

```
def sutImage = docker.image('elastest/demo-web-java-test-sut')
            echo 'Start SUT'
            sutImage.withRun("--name ${env.ET_SUT_CONTAINER_NAME}") { c ->
```
<p></p>

*   **Wait for Sut** : You have to obtain the Sut network and ip and run check image (elastest/etm-check-service-up) provided by ElasTest to wait for the Sut to be ready to be used.
<p></p>

```
def sutContainerName = env.ET_SUT_CONTAINER_NAME;
            def sutNetwork = getFirstNetwork(sutContainerName)
            def sutIp = containerIp(sutContainerName,network)
            sh 'docker run -e IP=' + sutIp + ' -e PORT=8080 --network=' + sutNetwork + ' elastest/etm-check-service-up'
```
<p></p>

*   **Test Execution** : Finally, the tests should be executed to verify that the SUT is working correctly. Remember that you have to configure the Sut ip as a environment variable or pass it as a maven property due to the browsers we have used need to know where is the SUT located.

<p></p>

```
....
withEnv(['ET_SUT_HOST=' + sutIp]) {
            echo 'Set up test environment'
            mvnHome = tool 'M3.3.9'
            echo 'Cloning repository'
            git 'https://github.com/elastest/demo-projects'
            echo 'Run test'
            sh "cd ./web-java-test/;'${mvnHome}/bin/mvn' -Dtest=WebAppTest test"
        }
....
```

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>You can refresh your mind visiting our tutorial <a href="/docs/testing/e2e-rest">How implement a test</a>.</i></p></div>
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