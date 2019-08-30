<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Using EMS to build tests with dynamic info</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

Suppose we have a webserver and want to assess that when a client is downloading a file and then a second one starts a download too, then the bandwidth consumption roughly doubles.

The ElasTest infrastructure provides us the means to extract data from the server automatically, and we can use the EMS to organize and process this data according to our desired property.

The following example is **already included in ElasTest** within the project **`EMS Example`**, although we are going to explain how to create it.

**If you like see the documentation of EMS click in this** [link](/test-services/ems/)

<h4 class="small-subtitle">The Sut</h4>

For this example we will use a well-known webserver, nginx.
The SuT configuration is the following:

-   **SuT Name**: **`nginx`**
-   Select **`Deployed By Elastest`**
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

<p></p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/sut.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/sut.png"/></a>
</div>

The sut is an ngninx application listening on port `80`, with a file called `sparse` of 500GB in its server root directory.

<h4 class="small-subtitle">The TJob</h4>

The TJob is a custom application whose source code can be found [here](https://github.com/elastest/elastest-monitoring-service/tree/master/e2e-test/tjob), and which has been deployed as a Docker image to Dockerhub at [imdeasoftware/e2etjob](https://hub.docker.com/r/imdeasoftware/e2etjob).

The TJob configuration is the following:

-   **TJob name**: **`Double bandwidth`**
-   **Current SuT**: Select **`nginx`**
-   **Environment Docker Image**: **`imdeasoftware/e2etjob`**
-   **Commands**: 

        cd /go;./tjob

-   **Test Support Services**: Check **`EMS`**

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/tjob1.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/tjob1.png"/></a>
</div>

And, of course, we have to make sure that the EMS checkbox is checked:
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/tjob2.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/tjob2.png"/></a>
</div>

When the TJob starts, it deploys these event stampers:
```
when e.strcmp(type,"net") do #NetData
when e.path(message) do #TJobMsg

when e.tag(#testresult) do #websocket 
when e.tag(#lowavg) do #websocket 
when e.tag(#highavg) do #websocket 
```
We can see that
+ An event stamped with channel **`#testresult`** will also be stamped with channel stamp **`#websocket`**.
+ An event whose payload is **`{message: {info: "Info"}}`** will be stamped with stamp **`#TJobMsg`** but not with channel stamp **`#NetData`**.
+ An event whose payload is **`{type: "net", message: "Server"}`** will be stamped with channel stamp **`#NetData`** but not with channel stamp **`#TJobMsg`**.
+ Finally, an event whose payload is **`{message: {info: "Info"}, type: "net"}`** will be stamped with both channel stamps **`#TJobMsg`** and **`#NetData`**.

The TJob also deploys the following monitoring machine at startup:

```
pred isnet := e.tag(#NetData) /\ e.strmatch(containerName, "nginx")

stream bool lowstarted := e.strmatch(message, "STARTING FIRST DOWNLOAD")
stream bool lowended := e.strmatch(message, "STARTING SECOND DOWNLOAD")
stream bool highstarted := e.strmatch(message, "STARTING SECOND DOWNLOAD")
stream bool highended:= e.strmatch(message, "FINISHIN SECOND DOWNLOAD")
stream bool tjobfinished := e.strmatch(message, "FINISHING TEST")

stream num outBandwidth := if isnet then e.getnum(net.txBytes_ps)

stream bool low_is_running := Prev lowstarted /\ ~Prev lowended
stream bool high_is_running := Prev highstarted /\ ~Prev highended

stream num avgbwlow := avg(outBandwidth within low_is_running)
stream num avgbwhigh := avg(outBandwidth within high_is_running)

stream bool testcorrect := Prev low_is_running /\ Prev high_is_running /\ avgbwhigh > avgbwlow * 1.8

trigger tjobfinished do emit testcorrect on #testresult
```

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

After the initialization phase, the TJob connects to the EMS websocket endpoint and also proceeds to perform the downloads, printing a message beteween the different stages.
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
