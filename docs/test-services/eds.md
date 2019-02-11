<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Elastest Device Emulator Service (EDS)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h3 class="holder-subtitle link-top">Introduction</h3>


The main goal of this service is to emulate behavior of sensors, actuators and smart devices  which is suitable for ElasTest platform. The service concentrates on providing emulated devices to realize and test **`Industrial Internet of Things (IIOT)`** applications in ElasTest. The motivation for  providing EDS in ElasTest are the following:  

* **Device Emulation** : Provide emulated devices to the user on-demand and help in managing them.
* **Build an IIoT application** : The emulated devices provided by EDS can  be wired as required by user to realize an IIoT application.
* **Scalability and reusability** : The IIoT applications are scalable and reusable.
* **Change the behavior of emulated devices** : The user can dynamically change the behavior of the system during run time for the purpose of aiding testing of IIoT application functionality.
* **External smart devices or applications** : It is possible that external real-world entities such as smart devices or applications can also be interfaced and tested with EDS.


In order to use the facilities offered by EDS, make sure that EDS is checked while configuring a TJob.
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/eds/selecteds.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/eds/selecteds.png"/></a>
</div>

<h3 class="holder-subtitle link-top">EDS Basics</h3>

The user is advised to go through this section completely before proceeding further as this section would help user to understand the programming paradigm used in EDS.

Communication between machines in industries is generally referred to as **Machine to Machine (M2M)** communication.
M2M communication is accomplished based on industry standards and one of them being [oneM2M](www.onem2m.org). EDS uses [OpenMTC](www.openmtc.org) as a middleware for communication. The external and internal smart devices or user applications communicate using the publish subscribe paradigm.

<h4 class="small-subtitle">OpenMTC</h4>

It is an open source reference implementation of the oneM2M standard for industrial machine to machine communication. The user can find more information in the [official website of OpenMTC](www.openmtc.org) and the open source implementation can be downloaded from the [GitHub repositor](https://github.com/OpenMTC/OpenMTC). OpenMTC is a generic FIWARE enabler. In order to understand the key concepts of programming using OpenMTC, the user is advised to go through the online documentation of OpenMTC [documentation page](https://fiware-openmtc.readthedocs.io/en/latest/index.html).


A key component which enables M2M communication mechanism is the Common Service Entity (CSE) or commonly addressed in the rest of the text as the **`oneM2M gateway`** or in short **`gateway`**. The gateway serves a common end point for all the entities requiring to communicate, provided they follow a certain guidelines:  

* **`oneM2M gateway endpont`** : This endpoint forms the basis for all the communication. Given that the gateway is running on a host, the end point can be found at:
```
http://<Host_IP_Address>:8000/
```
The word **`onem2m`** is suffixed to access the gateway functionalities.

* **`oneM2M Application Entity (AE)`** : The application entity forms a generic representation of oneM2M application, under which there could be one or more containers ordered in a way however visualized by the user.
* **`oneM2M Containers`** : Not to confuse with a docker container, these containers are placeholders for content instances.
* **`oneM2M Content Instances (CI)`** : Content instances are values which are stored in the oneM2M containers, depending upon how the containers are defined, there could be one or more content instances all of them identifiable with a unique ID.
* **`oneM2M path`** : This is a standard path obtained as registration of hierarchical name spaces obtained as a combination of AEs and CIs. For example, if we have an AE name "my_app" and a container by name "my_container" registered under "my_app" then, the container "my_container" can be reached at:
```
http://<Host_IP_Address>:8000/onem2m/my_app/my_container
```
However when working in oneM2M applications, it is enough to specify the path as **`onem2m/my_app/my_container`**.

<h4 class="small-subtitle">The programming paradigm</h4>

The programming paradigm that can be followed to implement applications are:  

* **`Create meaningful paths`** : Create paths that are meaningfully constructed as a result of combination of AEs and containers. These paths can be created by user applications.
* **`Subscribe to containers`** : Applications can subscribe to specific containers for input, thanks to the unique and meaningful paths. Once data is pushed to the container, the application is notified and a corresponding handler is executed. This mechanism forms the input event for the application.
* **`Push data to containers`** : Applications intending to communicate their output can push data to containers, so that other applications can be notified. This mechanism forms the output event for the application.

<h4 class="small-subtitle">Communication mechanism</h4>

The oneM2M paths in OpenMTC support REST API. It is possible for the user to interact with the oneM2M paths using the following methods:  

* **`CURL requests`** : It is possible for the user to post or retrieve content instances in a given path. The data is represented in JSON format and the content instance itself is available in the key **`con`**. For example:
```
curl -vv -X POST -H 'content-type:application/json' -d '{"m2m:cin": {"cnf": "application/json:1", "con": "'$(echo "[{'register': {'application': {'app_ID': 'foo', 'request_ID': 'bar'}}}]" | base64 -w 0)'"}}'
http://localhost:8000/onem2m/EDSOrch/edsorch/request
```
Notice that the value of the key **`con`** is base64 encoded.

* **`OpenMTC low level SDK`**: It is possible with this method to construct desired requests in the OpenMTC framework. The user can find more information the documentation page of [low-level CSE client](https://fiware-openmtc.readthedocs.io/en/latest/sdk-client/index.html). Essentially, the steps include the following:  
    * Create a oneM2M HTTP Client by specifying the required endpoint.
    * Create a onem2m request by sufficiently expressing the request type and it's required function.

* **OpenMTC Application SDK**: It is possible with this method implemented applications which can sufficiently call method to create containers, push data to container at a given path, subscribe to a container at a given path and many more. More information can be found in the documentation page of [using the application framework](https://fiware-openmtc.readthedocs.io/en/latest/sdk-client/index.html).

<h3 class="holder-subtitle link-top">Simple IIoT application</h3>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/eds/eds_app.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/eds/eds_app.png"/></a>
</div>

The figure above depicts a simple IIoT application composed of a temperature sensor, a logic and an actuator which are denoted by green boxes representing OpenMTC applications. The red boxes denote OpenMTC containers. The functionality of the application be understood as follows:  

* **`Temperature sensor`** : Is an application that creates the data container. Produces a value every 5 seconds and pushes it to the data container.
* **`Actuator`** : Is an application that creates two containers, data\_in and data\_out and subscribes to the data_in container which acts as the input for the actuator. The actuator function is to wait for a delay which 3 seconds, before pushing the received data to data\_out. The delay parameter emulates the actuation behavior.
* **`Logic`** : The logic is an application that subscribes to the data container which acts as an input. When sensor pushes to data container, the logic is notified and it invokes a handler where user logic is applied and if the logic is satisfied, the logic pushes the data received from sensor to the data\_in container of the actuator.

#### Run Standalone OpenMTC applications
For the benefit of user, an example implementation of the IIoT application is available in the **[Example Implementation](https://github.com/elastest/elastest-device-emulator-service/tree/master/demo/examples)**. The examples are self documented. Please follow the instructions in [README.md](https://github.com/elastest/elastest-device-emulator-service/blob/master/demo/examples/README.md).

Following points can be observed in the implementation:  
* It is **mandatory** to run a gateway and specify it's end point in the applications.
* The applications inherit and extend a class called XAE in their implementations. Specifically it is required to override the **`_on_register`** method according to the requirements of the user. For example, creating containers, subscribing to containers, specifying variables etc.
* The example applications once initiated successfully run forever unless terminated.
* In the example applications, it is possible to witness creation of containers, subscribing to containers as well as pushing to data to containers based on when and what the example application needs to perform.

<h4 class="small-subtitle">Run and test IIoT application using ElasTest</h4>

EDS is a Test Support Service (TSS) provided in ElasTest which is available as a docker image (**elastest/eds-base**). EDS is composed of three components:  

* EDS gateway : An OpenMTC gateway.
* EDS Orchestrator : An application which orchestrates the activities of EDS. Available in the path **`onem2m/EDSOrch/edsorch/`**. Opens up for communication on request, response and status channels:  

    * **request channel** : **`onem2m/EDSOrch/edsorch/request`**
    * **response channel** : **`onem2m/EDSOrch/edsorch/response`**
    * **status channel** : **`onem2m/EDSOrch/edsorch/status`**

* Device emulators: They are applications which emulate sensors and actuators. They initialize the devices as new threads and push or subscribe to paths as instructed by orchestrator. They are run internally by EDS orchestrator. Currently there are two device emulators available which are **TemperatureSensor** and **SimepleActuator** which have paths **`onem2m/TemperatureSensor`** and **`onem2m/SimpleActuator`** respectively. Similar to orchestrator, they have request, response and status channels.

The **request** channel allows user applications to make specific requests to EDS.
The user applications need to subscribe to **response** channel so that they can receive the processed results of requests sent to the request channel.
Using the **status** channel the user application can make sure if the components of EDS are free to process a request.

User can find the documentation of the API in [EDS API](www.elastest.io/docs/api/eds).

In general the following procedure is to be followed when interacting with EDS:  

* Override the **`_on_register`** method of XAE class.
    * Register the application with a unique ID. Remember EDS interacts with one or more user applications, it needs to identify the user application to assign sensors and actuators. On successful processing of the instruction, this creates a path at **`onem2m/EDSOrch/<user_app_ID>`**. Also EDS creates containers, sensors and actuators under this path for future use to attach device containers under them.
    * Register a sensor or actuator: Remember to subscribe to response paths of the EDSOrch and device emulators to received the result. If a sensor is requested, it is available with a unique named container under **`onem2m/EDSOrch/<user_app_ID>/sensors/<unique_ID_of_sensor>/data`**. The user application can subscribe to the data container to receive the values generated by sensor. A similar behavior for actuator can be envisioned.
    * Similarly to modify the behavior of a device during run time, launch **`modify`** request with the unique ID of the sensor you would like to modify and send it to the corresponding device emulator.

<h5 class="small-subtitle">ElasTest EDS SuT configuration</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/eds/elastestedssut.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/eds/elastestedssut.png"/></a>
</div>
The figure shows the configuration of SuT for ElasTest. The application implemented is the same as the one implemented with standalone example discussed previously. Here the application only requests and uses the devices and applies the application logic.
The configuration is as follows:  

-   **SuT Name**: **`EDS SuT`**
-   **SuT Description**: **`Sensor Actuator Logic SuT`**
-   Checked **`Deployed by ElasTest`**
-   Checked **`With Commands Container`**
-   **Commands container image**: **`elastest/eds-base`**
-   **Commands**:

        git clone https://github.com/elastest/elastest-device-emulator-service.git /tmp/eds

        # create app template
        ./create-app-structure -d TestApplication
        cp /tmp/eds/demo/eds_sut/TestApplication/* apps/TestApplication/src/testapplication/

        sh ./apps/test-application -v &

        python -m SimpleHTTPServer 9000

-   Checked **`SuT in Commands Container`**
-   Wait for service on **port** **`9000`** to confirm SuT has started

The use is encouraged to investigate the implementation of SuT which can be found in the [EDS GitHub repository](https://github.com/elastest/elastest-device-emulator-service/tree/master/demo/eds_sut/TestApplication). The code is documented to provide hints about the working.

<h5 class="small-subtitle">ElasTest EDS TJob configuration</h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/eds/elastestedstjob.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/eds/elastestedstjob.png"/></a>
</div>
The above figure provides the configuration of TJob. The TJob is also an OpenMTC application, where the \__on\_register method is modified to subscribe to the available containers initialized by SuT. The TJob subscribes to the containers and verifies the functional aspects of the working of SuT in run time. For example, the TJob verifies for every input provided by the sensor to the data container, the time duration between successive inputs which should not be greater than 6 seconds. Furthermore tests are implemented using the unit testing framework of Python and the tests are run using the xmlrunner to produce test results so that ElasTest is able to analyze the results produced.

The test configuration is as follows:  

-   **TJob Name**: **`EDS TJob`**
-   **Test Results Path**: **`/tmp/test-reports`**
-   **Current SuT**: **`EDS SuT`**
-   **Environment docker image**: **`elastest/eds-base`**
-   **`Uncheked`** **Use docker image command**.
-   **Commands**:

        # Give enough time for full initialization of SuT
        sleep 10

        git clone https://github.com/elastest/elastest-device-emulator-service.git /tmp/eds

        # create TJob app template
        ./create-app-structure -d TestJob
        cp /tmp/eds/demo/eds_tjob/tjob1/* apps/TestJob/src/testjob/

        sh ./apps/test-job -v

-   **`Unchecked`** **Activate Multi Configuration TJob**
-   **`Checked`** **EDS** in Test Support services

The user is encouraged to learn more on test implementation of TJob which can be found in the [EDS GitHub repository](https://github.com/elastest/elastest-device-emulator-service/tree/master/demo/eds_tjob/tjob1)

It is to be noted that both SuT and TJob rely on the environment variable **`ET_EDS_EDS_BASE_API`** to locate EDS and thus the OpenMTC gateway. This modification can be found in the **`__main__.py`** file under the SuT and TJob repository locations.
