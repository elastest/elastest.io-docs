<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Software under Test</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest supports two deployment modes of SuT:

-   **SuT deployed by ElasTest**: your software is packaged as Docker container/s. It can be a single Docker image or a docker-compose.
-   **SuT deployed outside ElasTest**: your software is already deployed somewhere.

When creating a new SuT you are able to defined what mode of deployment ElasTest should work with.

<h4 class="holder-subtitle link-top">SuT deployed by ElasTest</h4>

<h5 class="small-subtitle">With Commands Container</h5>

Your SuT is packaged as a Docker image. You must write the _Commands Container Image_ and the commands below. These commands will run like the docker image CMD.

**Fields to declare:**

-   **Commands container images**: name of the container image
-   **Commands**: commands to execute
-   **Port**: port that ElasTest should wait for to be available before running your TJobs
-   **Protocol**: protocol of the SuT url. Only Http and Https are available.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/commands_container.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/commands_container.png"/></a>
</div>

Furthermore you can choose between three options into `With Commands Container`:

<h6 class="small-subtitle">SuT In Commands Container</h6>
You can start a SuT from commands. For example, you can clone and build maven project from GitHub and after start generated java jar file.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_in_commands_container.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_in_commands_container.png"/></a>
</div>

<h6 class="small-subtitle" id="sutInNewContainer">SuT In New Container</h6>
You can start a SuT from docker image. The difference with `With Docker Image` option is that you can generate a docker image in execution time. For example, you can clone a project from GitHub and after generate docker image and start it.

It's necessary sets on `docker run` command the `--name` parameter with the `$ET_SUT_CONTAINER_NAME` environment variable.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_in_new_container.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_in_new_container.png"/></a>
</div>

<h6 class="small-subtitle">SuT In Docker Compose</h6>
You can start a SuT from docker compose. The difference with `With Docker Compose` option is that you can use a docker-compose file stored, for example, into GitHub instead of copy and paste it into ElasTest.

It's necessary sets on `docker-compose up` command the `-p` parameter with the `$ET_SUT_CONTAINER_NAME` environment variable.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_in_docker_compose.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_in_docker_compose.png"/></a>
</div>

<h5 class="small-subtitle">With Docker image</h5>

Your SuT is packaged as a Docker image. ElasTest will pull it from DockerHub and run it as the `Dockerfile` states.

**Fields to declare:**

-   **Docker image**: name of the image (tagged or untagged)
-   **Port**: port that ElasTest should wait for to be available before running your TJobs
-   **Protocol**: protocol of the SuT url. Only Http and Https are available.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/docker_image.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/docker_image.png"/></a>
</div>

<h5 class="small-subtitle">With docker-compose</h5>

Your SuT is declared as a docker-compose. ElasTest will pull all the necessary images from DockerHub and run them as the field _Docker Compose_ states

**Fields to declare:**

-   **Docker Compose**: your `docker-compose.yml` file. Simply copy-paste its content here
-   **Main Service Name**: the name of the service that ElasTest should wait for to be up before running your TJobs (the specific port is declared in the next field _Port_)
-   **Port**: port that ElasTest should wait for to be available before running your TJobs (applied to the service declared in the previous field _Main Service Name_)
-   **Protocol**: protocol of the SuT url. Only Http and Https are available.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/docker_compose.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/docker_compose.png"/></a>
</div>

<h4 class="holder-subtitle link-top">SuT outside ElasTest</h4>

<h5 class="small-subtitle">No instrumentation</h5>

Your SuT is already deployed on an external server and you don't want to send any logs or metrics to ElasTest.

**Fields to declare:**

-   **SuT IP**: IP or DNS of your SuT. Thanks to this field your TJobs may know how to reach your SuT through environment variable `ET_SUT_HOST`. Check [Environment variables](/testing/environment-variables) to learn more.
-   **SuT Protocol**: Protocol of your SuT. **`http`** is selected by default.

**Optional Fields:**

-   **SuT Port**: Port of your SuT.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_outside_no_instrumentation.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_outside_no_instrumentation.png"/></a>
</div>

<h5 class="small-subtitle">Manual instrumentation</h5>

Your SuT is already deployed on an external server and you want to manually send its logs and metrics to ElasTest.

**Fields to declare:**

-   **SuT IP**: IP or DNS of your SuT. Thanks to this field your TJobs may know how to reach your SuT through environment variable `ET_SUT_HOST`. Check [Environment variables](/testing/environment-variables) to learn more.
-   **SuT Protocol**: Protocol of your SuT. **`http`** is selected by default.

**Optional Fields:**

-   **SuT Port**: Port of your SuT.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_outside_manual_instrumentation.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_outside_manual_instrumentation.png"/></a>
</div>

After filling SuT name and description fields, click on _Save and get monitoring details_ button to get all the necessary fields to manually instrument your server following [these instructions]().

<h5 class="small-subtitle">Instrumented by ElasTest</h5>

Your SuT is already deployed on an external server and you want to automatically send its logs and metrics to ElasTest. Elastest will be responsible for accessing your Sut to send monitoring traces, through the ElasTest Instrumentation Manager (EIM) service.

EIM is integrated with ElasTest and allows to instrumentalize and de-instrumentalize the deployed SuTs. TJobs can also executed to verify that the SuTs are successfully instrumentalized.

**Fields to declare:**

-   **SuT IP**: IP or DNS of your SuT. Thanks to this field your TJobs may know how to reach your SuT through environment variable `ET_SUT_HOST`. Check [Environment variables](/testing/environment-variables) to learn more.
-   **SuT Protocol**: Protocol of your SuT. **`http`** is selected by default.
-   **User**: The user for access to your SuT.
-   **Private Key**: The Private Key for access to your SuT.
-   **Instrumentalize**: If checked, it will be registered in the EIM so that the EIM can install Beats agents for SuT monitoring.
-   **Sut Logs Path**: Full path where the logs that you want to monitor are located. One or more routes can be indicated.

**Optional Fields:**

-   **SuT Port**: Port of your SuT.
-   **Password**: Password of your SuT.
-   **Dockerized SuT**: To indicate that your Sut consists of one or more Docker containers. You must indicate The path where docker writes the **`containers logs`** and the path of **`docker.sock`**.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_outside_eim.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_outside_eim.png"/></a>
        <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_outside_eim2.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_outside_eim2.png"/></a>
</div>

Once the Sut is created, it can be associated with one or more TJobs of the same project. Each time a TJob is executed, ElasTest will install beat agents in the Sut to monitor the execution. The installed beats are:

-   [Packetbeat](https://www.elastic.co/guide/en/beats/packetbeat/5.6/packetbeat-overview.html)
-   [Filebeat](https://www.elastic.co/guide/en/beats/filebeat/5.6/filebeat-overview.html)
-   [Metricbeat](https://www.elastic.co/guide/en/beats/metricbeat/5.6/metricbeat-overview.html)

<div class="range range-xs range-xs-center warning-range">
    <div class="cell-xs-2 cell-lg-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
    <div class="cell-xs-10 cell-lg-11 warning-text"><p><i>IMPORTANT: For proper operation, there should not be more than one execution of the same TJob simultaneously.</i></p></div>
</div>


<h5 id="outsideExternalES" class="small-subtitle">Use external Elasticsearch</h5>

Your SuT is already deployed on an external server and you store your monitoring traces in your own Elasticsearch. Elastest will be responsible for accessing your Elasticsearch to get monitoring traces.

**Fields to declare:**

-   **SuT IP**: IP or DNS of your SuT. Thanks to this field your TJobs may know how to reach your SuT through environment variable `ET_SUT_HOST`. Check [Environment variables](/testing/environment-variables) to learn more.
-   **SuT Protocol**: Protocol of your SuT. **`http`** is selected by default.
-   **Elasticsearch IP**: IP or DNS of your Elasticsearch.
-   **Elasticsearch Port**: Port of your Elasticsearch.
-   **ES Indices**: Elasticsearch indices where the Sut monitoring traces be stored. If there are more than one index, type them separated by commas.

**Optional Fields:**

-   **SuT Port**: Port of your SuT.
-   **Elasticsearch User**: The User of your Elasticsearch.
-   **Elasticsearch Pass**: The Password of your Elasticsearch.
-   **Use Indices by Execution**: If checked, a parameter with the indices will be added. For each TJob Execution, you can to indicate the inidices.

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/testing/images/sut/sut_outside_external_elasticsearch.png"><img class="img-responsive img-wellcome" src="/docs/testing/images/sut/sut_outside_external_elasticsearch.png"/></a>
</div>
