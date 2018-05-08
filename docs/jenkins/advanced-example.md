<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Advanced example</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Pipeline Job Examples</h4>

Bellow, you will find two examples of pipeline where using the ElasTest plugin and implements severals configurations, a SUT is started and a test battery is executed on it.
To configure this option, ElasTest provides the connection info using [environment variables](/testing/environment-variables)

The installation of ElasTest, Jenkins and the collaboration between them, allows several configurations. In this case, ElasTest and Jenkins are installed on the same machine.

<h5>Web App</h5>

This pipeline configures the ElasTes plugin, clones the repository with the test, starts the SUT, starts a beat service to send metrics to ElasTest and configures the log output of the SUT container to send the logs to ElasTest as well.

```
node{
    elastest(tss: ['EUS']) {
        stage ('Executing Test') {
            echo 'Print env variables'
            sh 'env'
            
            def sutImage = docker.image('elastest/demo-web-java-test-sut')
            def beatImage = docker.image('elastest/etm-dockbeat:latest')
            echo 'Start beat'
            beatImage.withRun("-e LOGSTASHHOST=${env.ET_MON_LSBEATS_HOST} -e LOGSTASHPORT=${env.ET_MON_INTERNAL_LSBEATS_PORT} -v /var/run/docker.sock:/var/run/docker.sock --network=elastest_elastest") { c1 ->
                sh 'sleep 5'
                echo 'Start SUT'
                sutImage.withRun("--name ${env.ET_SUT_CONTAINER_NAME} --log-driver=syslog --log-opt syslog-address=tcp://${env.ET_MON_LSTCP_HOST}:${env.ET_MON_LSTCP_PORT} --log-opt tag=${env.ET_SUT_LOG_TAG} --network=elastest_elastest") { c ->
                    echo "${c.id}"
                    sh 'sleep 5'
                    def sutIp = containerIp("${env.ET_SUT_CONTAINER_NAME}")
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
}

def containerIp(containerName) {
    echo "Inside containerIp function"
    containerIp = sh (
        script: "docker inspect --format=\"{{.NetworkSettings.Networks.elastest_elastest.IPAddress}}\" "+ containerName,
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

*   **Docker beat configuration** : To send the SUT’s metrics to ElasTest it is necessary to start a dockbeat service

<p></p>

```
.......

def beatImage = docker.image('elastest/etm-dockbeat:latest')
echo 'Start beat'
beatImage.withRun("-e LOGSTASHHOST=${env.ET_MON_LSBEATS_HOST} -e LOGSTASHPORT=${env.ET_MON_INTERNAL_LSBEATS_PORT} -v /var/run/docker.sock:/var/run/docker.sock --network=elastest_elastest") { c1 ->
  .......
}
```
<p></p>

*   **Sut configuration** : Once the dockbeat has already been started, the SUT must be started
<p></p>

```
def sutImage = docker.image('elastest/demo-web-java-test-sut')
....
echo 'Start SUT'
sutImage.withRun("--name ${env.ET_SUT_CONTAINER_NAME} --log-driver=syslog --log-opt syslog-address=tcp://${env.ET_MON_LSTCP_HOST}:${env.ET_MON_LSTCP_PORT} --log-opt tag=${env.ET_SUT_LOG_TAG} --network=elastest_elastest") { c ->
    ....
}
```
<p></p>

*   **Test Execution** : Finally, the tests should be executed to verify that the SUT is working correctly. Remember that you have to obtain the SUT ip and configure it as a environment variable or pass it as a maven property due to the browsers we have used need to know where is the SUT located.

<p></p>

```
....

def sutIp = containerIp("${env.ET_SUT_CONTAINER_NAME}")
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