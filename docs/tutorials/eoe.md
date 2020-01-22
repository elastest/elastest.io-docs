<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Test Orchestration with EOE (ElasTest Orchestrator Engine)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h3 class="small-subtitle" id="eoe">ElasTest Orchestrator Engine (EOE)</h3>

The <a href="https://github.com/elastest/elastest-orchestration-engine" target="_blank">ElasTest Orchestration Engine (EOE)</a> is the component responsible of implementing the concept of orchestration within Elastest, understood as a novel way to select, order, and execute a group of TJobs.

To that aim, we have leveraged the pipelines Jenkins notation for the topology generation by means of a [Jenkins shared library]. This library exposes a simple API to orchestrate testing jobs. The orchestrator library API is summarized in the following table:

Method | Description
--- | ---
**`runJob(String jobId)`** |  Method to run a job given its identifier (*jobId*).This method returns a boolean value: **`true`** if the execution of the job finishes correctly and **`false`** if fails
**`runJobDependingOn(boolean verdict, String job1Id, String job2Id)`** |  Method allows to run one job given a boolean value (typically a verdict from another job). This boolean value is passes in the first argument (called verdict in the method signature). If this value job with identifier `job1Id` is executed. Otherwise it is executed **`job2Id`**
**`runJobsInParallel(String... jobs)`** |  This method allows to run a set of jobs in parallel. The jobs identifier are passes using a variable number of arguments (*varargs*)

Moreover, the exit condition for the orchestrated job can be also configured:

Method | Description
--- | ---
**`EXIT_AT_END`** |  The orchestration finishes at the end (option by default)
**`EXIT_ON_FAIL`** |  The orchestration finishes when any of the TJobs fail
**`EXIT_ON_PARALLEL_FAILURE`** |  The orchestration finishes when any a set of parallel TJobs fail

Finally, the verdict of a group of parallel jobs can be also configured:

Method | Description
--- | ---
**`AND`** |  The verdict of a set of jobs executed in parallel is **`true`** only if all the jobs finish correctly
**`OR`** |  The verdict of parallel jobs is **`true`** when at least one of the jobs finishes correctly

Other configurations:

Method | Description | Use Example
--- | --- | ---
**`setPacketLoss`** | If a SuT instrumented By ElasTest through EIM is used, one or more packet loss values can be set. If more than one is specified, the job will be run as many times as there are values. | setPacketLoss(['0.01', '0.02'])
**`setCpuBurst`** | If a SuT instrumented By ElasTest through EIM is used, one or more cpu burst (stress) values can be set. If more than one is specified, the job will be run as many times as there are values. | setCpuBurst(['0.2'])
**`checkTime`** | Allows to check if an execution lasts less (LessThan) or more (GreaterThan) than the indicated time (In milliseconds, seconds, minutes, etc.). | checkTime(Compare.LessThan, 60, TimeUnit.SECONDS)

At the moment, only packet loss and cpu burst can be set separately, so the two cannot be set at the same time.

How to install
-----------------
- Navigate to **Manage Jenkins** in your Jenkins.
- Click to **System Configuration**
- Add new library in **Global Pipeline Libraries** with name **OrchestrationLib** and default version **master**
- Select **Modern SCM**
- Select **GitHub**
- Owner: **elastest**
- Repository: **elastest-orchestration-engine**
- Save changes

<h3 class="small-subtitle" id="eoe-tutorial">QoE testing using EOE</h3>

The first thing you must do is **`create an instance of OpenVidu in AWS`**, which will be the SuT we will use.

To do this, you must use [this file for CloudFormation](https://github.com/elastest/codeurjc-qe-openvidu/blob/master/src/test/resources/openvidu-sut.yml) and wait for the instance to start completely.

The next thing you do is **`create a new project in ElasTest`** with the name you want. Let's assume it's called Jenkins Examples. Within this project you must **`create a new Sut`** with the following configuration:

-   **SuT Name:** Whatever you want, for example **OpenVidu AWS**
-   Select "**Deployed outside Elastest**" and "**Instrumented by ElasTest**"
-   **SuT IP:** the ip of the AWS instance
-   **Protocol:** https
-   **Port:** 4443
-   **User:** ubuntu
-   **Password:** 1234
-   **Private Key:** the private key to connect to the instance. (-----BEGIN RSA PRIVATE KEY-----...)
-   **Instrumentalize:** cheked
-   **SuT Logs Paths:**
    -   /var/log/openvidu.log
    -   /var/log/kurento-media-server/*.log
-   Save

Once this is done, you must **go to the Jenkins** section to start and access Jenkins. In Jenkins, the first thing you should do if you haven't done it before is to configure the EOE library as indicated in this documentation.

You must now **`create a new Pipeline Job`** with the following settings:

-   **Name:**  Whatever you want, for example **quality-of-experience**
-   **Parameters:**
    -   **Name:** AWS_ACCESS_KEY_ID **| Value:** your AWS access key id
    -   **Name:** AWS_SECRET_ACCESS_KEY **| Value:** your AWS secret access key
    -   **Name:** AWS_KEY_NAME **| Value:** your AWS key name
    -   **Name:** AWS_SSH_PRIVATE_KEY **| Value:** your AWS private key. *It's important that you replace line breaks with **\r\n** literal*
    -   **Name:** AWS_SECURITY_GROUPS **| Value:** your AWS security group with the following format -> ["securitygroupname"]
    -   **Name:** ET_MON_LSHTTPS_API **| Value:** http://etm:5003/api/monitoring/
-   **Pipeline script:**
    - In the following script you need to **replace the sut value** (*SUTIDHERE*) with the sut id you created earlier.
    - You'll also have to **replace the project name** if you put in another name other than *Jenkins Examples*

            node{
                elastest(tss: ['EUS'], surefireReportsPattern: '**/target/surefire-reports/TEST-*.xml', project: 'Jenkins Examples', sut: SUTIDHERE) {
                    stage ('Executing Test') {
                        sh 'env'
                        echo 'Set up test environment'
                        mvnHome = tool 'M3.3.9'
                        echo 'Cloning repository'
                        git 'https://github.com/elastest/codeurjc-qe-openvidu'
                        echo 'Run test'
                        sh "'${mvnHome}/bin/mvn' -B -DforkCount=0 test -Dtest=OpenviduWebRTCQoEMeterAWS;"
                        sh "sleep 20"
                        step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
                    
                    }        
                }
            }

Now **`create another pipeline job`** which will define the orchestration:

-   **Name:**  Whatever you want, for example **eoe**
-   **Pipeline script**
    -   If you put a different quality-of-experience name to the previous pipeline, replace it in the last line

            @Library('OrchestrationLib') _
            orchestrator.setContext(this)
            orchestrator.setExitCondition(OrchestrationExitCondition.EXIT_ON_FAIL)

            orchestrator.setPacketLoss(['0.20','0.40'])

            // Graph
            def result = orchestrator.runJob('quality-of-experience')


Run eoe and enjoy!