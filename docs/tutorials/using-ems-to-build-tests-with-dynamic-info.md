<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Using EMS to build tests with dynamic info</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

This tutorial aims to show the basic concepts and principles of the Elastest Monitoring Service, and its intended use. You can check the documentation of this service following this [link](/test-services/ems/).

In this example, we will use Elastest to assess that a webserver -- the System under Test -- is able to serve multiple clients, and uses as much bandwitdh as possible when doing so.

In particular, our TJob will start one download of a large file at the beginning of the test, and after some time, it will start a second one. The test passes if the bandwidth consumption with two downloads in parallel roughly doubles the bandwidth consumption with only one download going on.

The ElasTest infrastructure provides us with the means to extract data from the server running the test automatically. We use this feature to collect the network activity, which we will analyse in the EMS.

This example is **shipped along with ElasTest** within the project **`EMS Example`**, but we are going to explain how to create it.

<h4 class="small-subtitle">The System under Test</h4>

Our SuT is [nginx](https://www.nginx.com/), a well-known webserver.
The configuration of the System under Test in elastest is as follows:
-   **SuT Name**: **`nginx`**
-   Select **`Deployed by Elastest`**
-   Select **`With Docker Compose`**
-   **Docker Compose**:

        version: '3'

        services:

            nginx-service:
                image: nginx
                entrypoint:
                    - /bin/bash
                    - "-c"
                    - "dd if=/dev/random of=/usr/share/nginx/html/sparse bs=1024 count=1 seek=5242880000;nginx;sleep infinity"
                expose:
                    - "80"

-   **Main Service**: **`nginx-service`**
-   **Wait for http port**: **`80`**

The SuT configuration should look like this:
<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/sut.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/sut.png"/></a>
</div>

We use Docker Compose to make nginx serve a large file called `sparse` on the root path of the webserver, which will listen for incoming connections at port `80`.

<h4 class="small-subtitle">The TJob</h4>

The TJob exercising the SuT is an HTTP client written in Go, whose source coude can be found [here](https://github.com/elastest/elastest-monitoring-service/tree/master/e2e-test/tjob).
First, the TJob uses [the Elastest Monitoring Service API](https://elastest.io/docs/api/ems/) to deploy one Stamper and one Monitoring Machine.
The stamping rules at the file `stampers.txt` are the following:
```
when e.strcmp(type,"net") do #NetData
when e.path(message) do #TJobMsg

when e.tag(#testresult) do #websocket 
when e.tag(#lowavg) do #websocket 
when e.tag(#highavg) do #websocket 
```
We use the stampers to assign a tag to the input and output events according to their content.
When an input event has a string field called `type` whose value is `net`, then it is `#NetData`. When an input event has a field called `message`, then it is a `#TJobMsg`.
The output events tagged as `#testresult`, `#lowavg` and `#highavg` are output to the `websocket`, over which The TJob will be listening for events.

The Monitoring Machine at the file `sessiondef.txt` is the following:
```
pred isnet := e.tag(#NetData) /\ e.strmatch(containerName, "nginx")

stream bool lowstarted := e.strmatch(message, "STARTING FIRST DOWNLOAD")
stream bool lowended := e.strmatch(message, "STARTING SECOND DOWNLOAD")
stream bool highstarted := e.strmatch(message, "STARTING SECOND DOWNLOAD")
stream bool highended:= e.strmatch(message, "FINISHIN SECOND DOWNLOAD")
stream bool tjobfinished := e.strmatch(message, "FINISHING TEST")

stream num outBandwidth := if isnet then e.getnum(net.txBytes_ps)

stream bool low_is_running := Once lowstarted /\ ~Once lowended
stream bool high_is_running := Once highstarted /\ ~Once highended

stream num avgbwlow := avg(outBandwidth within low_is_running)
stream num avgbwhigh := avg(outBandwidth within high_is_running)

stream bool testcorrect := Once low_is_running /\ Once high_is_running /\ avgbwhigh * 0.8 > avgbwlow

trigger tjobfinished do emit avgbwlow on #lowavg
trigger tjobfinished do emit avgbwhigh on #highavg
trigger tjobfinished do emit testcorrect on #testresult
```
In this Monitoring Machine,
+ The predicate `isnet` filters the events containing information about the net.
+ The boolean streams `lowstarted/ended` indicate when the period of only one download starts and ends.
+ The boolean streams `highstarted/ended` indicate when the period of two downloads in parallel starts and ends.
+ The boolean stream `tjobfinised` indicates that the test is over.
+ The numeric stream `outBandwidth` extracts the bandwidth usage from a specific field in the event.
+ The boolean stream `low_is_running` indicates that only one download is being performed.
+ The boolean stream `high_is_running` indicates that two downloads are being performed in parallel.
+ The numeric stream `avgbwlow` calculates the average bandwidth when there is only one download.
+ The numeric stream `avgbwhigh` calculates the average bandwidth when there are two downloads in parallel.
+ The boolean stream `testcorrect` assesses that (a) there was a low bandwidth period, (b) there was a high bandwidth period, and (c), the average bandwidth during two parallel downloads is greater than (almost) the double of the bandwidth consumed by a single download.
+ Finally, the `trigger` clause emits the result of `testcorrect` over the channel `#testresult` when the TJob is over.

After the initialization phase, the TJob connects to the Elastest Monitoring Service websocket endpoint and proceeds to perform the downloads, printing a message beteween the different stages.
This can be seen in [the main TJob routine](https://github.com/elastest/elastest-monitoring-service/blob/master/e2e-test/tjob/main.go):
```go
fmt.Println("STARTING FIRST DOWNLOAD")
go DownloadFile(fileUrl)
time.Sleep(60 * time.Second)
fmt.Println("STARTING SECOND DOWNLOAD")
go DownloadFile(fileUrl)
time.Sleep(60 * time.Second)
fmt.Println("FINISHING SECOND DOWNLOAD")
time.Sleep(5 * time.Second)
fmt.Println("FINISHING TEST")
```

Then, the TJob checks the value of the event received over the channel `#testresult` and exits with a _success_ or _fail_ code accordingly.
The code of the Go program is designed to stress the System under Test, while all the numeric computation and property assessment is carried out in the Monitoring Service.

We have generated a Docker image for the TJob, and published at [imdeasoftware/e2etjob:1.2](https://hub.docker.com/r/imdeasoftware/e2etjob:1.2).
The configuration for the TJob at ElasTest is as follows:

-   **TJob name**: **`Double bandwidth`**
-   **Current SuT**: Select **`nginx`**
-   **Environment Docker Image**: **`imdeasoftware/e2etjob:1.2`**
-   **Commands**: 

        cd /go;./tjob

-   **Test Support Services**: Check **`EMS`**
The TJob configuration should look like this:
<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/tjob1.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/tjob1.png"/></a>
</div>

And, of course, we have to make sure that the EMS checkbox is checked:
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/tjob2.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/tjob2.png"/></a>
</div>

After some minutes, we should see that the test passes, which means that `nginx` behaves as expected:
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/tjobfinished.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/tjobfinished.png"/></a>
</div>