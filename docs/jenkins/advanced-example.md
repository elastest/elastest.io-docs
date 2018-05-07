<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Advanced example</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

<h4 class="holder-subtitle link-top">Pipeline Job Examples</h4>

Bellow, you will find two examples of pipeline where using the ElasTest plugin and implements severals configurations, a SUT is started and a test battery is executed on it.

The installation of ElasTest, Jenkins and the collaboration between them, allows several configurations. In this case, ElasTest and Jenkins are installed on the same machine.

<h5>Openvidu Job</h5>

This pipeline configures the ElasTes plugin, clones the repository with the test, starts the SUT, starts a beat service to send metrics to ElasTest and configures the log output of the SUT container to send the logs to ElasTest as well.

```bash
node{
    elastest(tss: ['EUS']) {
        stage ('Executing Test') {
            echo 'Print env variables'
            sh 'env'

            def sutImage = docker.image('elastest/demo-openvidu-test-sut2')
            def beatImage = docker.image('elastest/etm-dockbeat:latest')
            echo 'Start beat'
            beatImage.withRun("-e LOGSTASHHOST=${env.ET_SUT_MON_LSBEATS_HOST}  -v /var/run/docker.sock:/var/run/docker.sock --network=elastest_elastest") { c1 ->
                sh 'sleep 5'
                echo 'Start SUT'
                sutImage.withRun("--name ${env.ET_SUT_CONTAINER_NAME} --log-driver=syslog --log-opt syslog-address=tcp://${env.ET_SUT_MON_LSTCP_HOST}:${env.ET_SUT_MON_LSTCP_PORT} --log-opt tag=${env.ET_SUT_LOG_TAG} --network=elastest_elastest") { c ->
                    echo "${c.id}"
                    sh 'sleep 5'
                    def sutIp = containerIp("${env.ET_SUT_CONTAINER_NAME}")
                    withEnv(['ET_SUT_HOST=' + sutIp]) {
                        echo 'Set up test environment'
                        mvnHome = tool 'M3.3.9'
                        echo 'Cloning repository'
                        git 'https://github.com/elastest/demo-projects'
                        echo 'Run test'
                        sh "cd ./openvidu-test/;'${mvnHome}/bin/mvn' test"
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

```
node{
    elastest() {
        .......
    {
```

*   **Docker beat configuration** : To send the SUT’s metrics to ElasTest it is necessary to start a dockbeat service

```
.......

def beatImage = docker.image('elastest/etm-dockbeat:latest')
beatImage.withRun("-e LOGSTASHHOST=${env.ET_SUT_MON_LSBEATS_HOST}  -v /var/run/docker.sock:/var/run/docker.sock --network=elastest_elastest") { c1 ->
  .......
}
```

*   **Sut configuration** : Once the dockbeat has already been started, the SUT must be started

```
....
sutImage.withRun("--name ${env.ET_SUT_CONTAINER_NAME}
--log-driver=syslog
--log-opt syslog-address=tcp://${env.ET_SUT_MON_LSTCP_HOST}:${env.ET_SUT_MON_LSTCP_PORT} --log-opt tag=${env.ET_SUT_LOG_TAG}
--network=elastest_elastest") { c ->

    ....
}
```

*   **Test Execution** : Finally, the tests should be executed to verify that the SUT is working correctly. Remember that you have to obtain the SUT ip and configure it as a environment variable or pass it as a maven property due to the browsers we have used need to know where is the SUT located.

```
....
def sutIp = containerIp("${env.ET_SUT_CONTAINER_NAME}")
withEnv(['ET_SUT_HOST=' + sutIp]) {
    echo 'Set up test environment'
    mvnHome = tool 'M3.3.9'
    echo 'Cloning repository'
    git 'https://github.com/elastest/demo-projects'
    echo 'Run test'
    sh "cd ./openvidu-test/;'${mvnHome}/bin/mvn' test”
}
....
```

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>You can refresh your mind visiting our tutorial <a href="/docs/testing/e2e-rest">How implement a test</a>.</i></p></div>
</div>

<h5>Fullteaching Job</h5>

The ElasTest plugin configuration is exacly the same for this example. Nevertheless, in this case, we use docker-compose instead of docker to start a complex SUT.

In the following pipeline we need to clone the full-teaching-experiment repository where is the docker-compose file. This file has been used to start the SUT and the test that verify the right behavior of this. In this example the technique used to send the logs to ElasTest is different of the used it in the previous example. With ElasTest, a filebeat service is started as well and this service reads the containers logs with a specific name. For this reason, we need to use the option **-p** with **ET_SUT_CONTAINER_NAME** value when the docker-compose command is executed.

That environment variable that ElasTest sends to the Jenkins Job while it is executing, contains a prefix to set in all containers created by the docker-compose file.

In this case, to simplify the test configuration, we include the defined services inside of the docker-compose file in the elastest_elastest network. This prevents communication errors between the services that make up the SUT and other elements of the ElasTest platform such as the browsers.

```
node{
    elastest(tss: ['EUS']) {
        stage("Setting environment") {
            echo 'Environment variables'
            sh "env"
            git "https://github.com/elastest/full-teaching-experiment.git"
        }
        stage("Start Sut") {
            sh "cd docker-compose/full-teaching-et-network; export BUG_TAG=bug1; docker-compose -p ${env.ET_SUT_CONTAINER_NAME} --no-ansi up -d"
            sh "sleep 20"
        }
        stage("Run Tests") {
            try {
                def sutContainerNamePrefix = env.ET_SUT_CONTAINER_NAME.replaceAll("_","")
                def fullteachingContainerName = sutContainerNamePrefix + "_full-teaching_1"
                echo "Container name: " + fullteachingContainerName
                def sutIp = containerIp(fullteachingContainerName)
                echo 'Sut ip: '+ sutIp

                echo 'Running test'
                sh "mvn -Dapp.url=https://" + sutIp +":5001/ -Dtest=FullTeachingTestE2EREST,FullTeachingTestE2EVideoSession,FullTeachingTestE2EChat -B test"

            } finally {
                echo 'Stopping SUT'
                sh "cd docker-compose/full-teaching-env; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
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

*   **Setting Environment** : Clone the source repository where the test and the SUT are located.

```
stage("Setting environment") {
    echo 'Environment variables'
    sh "env"
    git "https://github.com/elastest/full-teaching-experiment.git"
}
```

*   **Start SUT** : Use the docker-compose command to start the SUT.

```
stage("Start Sut") {
    sh "cd docker-compose/full-teaching-et-network; export BUG_TAG=bug1; docker-compose -p ${env.ET_SUT_CONTAINER_NAME} --no-ansi up -d"
    sh "sleep 20"
}
```

You will must add **-p** option with the value **ET_SUT_CONTAINER_NAME** that contains the prefix that will be set in the name of the containers of the defined services in the docker-compose file. This is necessary so as filebeat can catch the logs generated by the SUT containers.
This is necessary to archive the logs generated by the SUT containers.

*   **Run Test**
    When the SUT is up the tests are executed, but before it’s necessary to know the SUT’s ip and pass it to the test. The browser needs this information to know where is the SUT.

```
try {
    def sutContainerNamePrefix = env.ET_SUT_CONTAINER_NAME.replaceAll("_","")
    def fullteachingContainerName = sutContainerNamePrefix + "_full-teaching_1"
    echo "Container name: " + fullteachingContainerName
    def sutIp = containerIp(fullteachingContainerName)
    echo 'Sut ip: '+ sutIp
    echo 'Running test'
    sh "mvn -Dapp.url=https://" + sutIp +":5001/ -Dtest=FullTeachingTestE2EREST,FullTeachingTestE2EVideoSession,FullTeachingTestE2EChat -B test"
} finally {
    echo 'Stopping SUT'
    sh "cd docker-compose/full-teaching-env; docker-compose --no-ansi -p ${env.ET_SUT_CONTAINER_NAME} down"
}
```

In this case the SUT’s ip is passed to the test as a maven property, but it’s also possible pass it as an environment variable:

```
withEnv(['ET_SUT_HOST=' + sutIp]) {
.....
}
```

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