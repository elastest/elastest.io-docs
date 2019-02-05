<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">ElasTest Monitoring Service (EMS)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

The ElasTest Monitoring Service (EMS) provides a monitoring infrastructure suitable for inspecting executions of a System Under Test (hereinafter "SuT") and the ElasTest platform itself online.
This service allows the user and the platform to deploy machines able to process events in real time and generate complex, higher level events from them. 
This can help to better understand what's happening, detect anomalies, correlate issues, and even stress the tests automatically; all of which aims to maximize the chances of uncover bugs and their causes. 

<h3 class="holder-subtitle link-top" id="options">How to use the EMS to ease test development in Elastest</h3>

To achieve its goal, the Elastest Monitoring Service provides an OpenAPI endpoint whose specification can be found at http://elastest.io/docs/api/ems.

To enable the use of the EMS in a TJob, make sure to tick the corresponding checkbox in the TJob configuration:
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/emscheckboxlayered.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/emscheckboxlayered.png"/></a>
</div>

The EMS will then receive metrics from the machine running the SuT and the lines written by both the TJob and the SuT to the standard output as events.

The host of the EMS is loaded into the environment variable **`ET_EMS_LSBEATS_HOST`** of the TJob, so the OpenAPI endpoint of the EMS is accessible by the TJob at the address **`${ET_EMS_LSBEATS_HOST}:8888`**.

The TJob can use the endpoint of the EMS to deploy _Monitoring Artifacts_, which are sets of rules to correlate events and check if one or many facets of the test are behaving properly.

You will find the methods to deploy, modify and undeploy Monitoring Artifacts listed and specified at http://elastest.io/docs/api/ems.
The functioning and syntax of the Monitoring Artifacts is explained in the next section.

<h3 class="holder-subtitle link-top" id="options">EMS internals</h3>

Events in the EMS consist of a timestamp, a payload or content, and a set of channels stamps indicating the channels to which they belong.
The Monitoring Artifacts can be separated into two main groups: the _Stampers_ and the _Machines_.
Events received by the EMS go through three stages:
1. First, incoming events are stamped with new channels following the rules of the Stampers.
2. Then, new events are created according to the deployed Machines.
3. Finally, outgoing events are stamped with further channels following the rules of the same Stampers.

<h4 class="small-subtitle">Stampers</h4>

Stampers are accessed through the endpoint **`${ET_EMS_LSBEATS_HOST}:8888/stamper`**.
To deploy a new stamper, we need to execute a **`POST`** method to this endpoint, specifying the version of the language used. The only supported version as of today is **`tag0.1`**, which makes the URI **`${ET_EMS_LSBEATS_HOST}:8888/stamper/tag0.1`** the only valid endpoint to deploy stampers.

<h5 class="small-subtitle">Stampers specification</h5>

The body of the **`POST`** request contains the specification of the stamper to be deployed, which consists in a set of lines of the form
```
when EXPRESSION do CHANNEL
```
This construct indicates that, when expression **`EXPRESSION`** is true for an event, then such an event must be stamped with channel stamp **`CHANNEL`**.
The EMS will compute the smallest set of channels that satisfies all the rules.
A **`CHANNEL`** is a string that starts with character **`#`**.
An **`EXPRESSION`** is one of the following constructions:
```
e.path(PATH)
e.strcmp(PATH, "STRING")
e.tag(CHANNEL)
~EXPRESSION
EXPRESSION /\ EXPRESSION
EXPRESSION \/ EXPRESSION
```
A **`PATH`** is a sequence of field ids separated by a dot.
The expression **`e.PATH(p)`** is true for an event if its payload is a JSON object containing a field at path **`p`**.
The expression **`e.strmatch(p,s)`** is true for an event if its payload is a JSON object containing a field at path **`p`** whose value matches the regular expression **`s`**.
The expression **`e.tag(c)`** is true for an event if it is stamped with the channel stamp **`c`**.
The expression **`~EXPRESSION`** is true for an event if its inner subexpression is false for it.
The expression **`EXPRESSION /\ EXPRESSION`** is true for an event if both subexpressions are true for it.
The expression **`EXPRESSION \/ EXPRESSION`** is true for an event if at least one of the subexpressions are true for it.

<h5 class="small-subtitle">Default rules and output endpoint</h5>

If the payload of an event is a JSON object that contains a field **`channels`** whose value is a JSON array of strings, then the event is stamped with each of these strings as channel stamps.
If none of the deployed Stampers contain a rule to stamp an event with channel **`#websocket`**, then every event is stamped with this channel stamp.
Events stamped with channel **`#websocket`** are transmitted over the websocket endpoint at the address **`${ET_EMS_LSBEATS_HOST}:3232`**.
The TJob can establish a websocket connection to this endpoint to receive the events processed and generated by the EMS stamped with the channel **`#websocket`**.

<h4 class="small-subtitle">Machines</h4>

Machines are accessed through the endpoint **`${ET_EMS_LSBEATS_HOST}:8888/MonitoringMachine`**.
To deploy a new monitoring machine, we need to execute a **`POST`** method to this endpoint, specifying the version of the language used. The only supported version as of today is **`tag0.1`**, which makes the URI **`${ET_EMS_LSBEATS_HOST}:8888/MonitoringMachine/tag0.1`** the only valid endpoint to deploy monitoring machines.

<h5 class="small-subtitle">Machines specification</h5>

The body of the **`POST`** request contains the specification of the machine to be deployed.
Each machine can be either a **predicate** over an event, a **stream** definition, or an action **trigger**.

1. A **predicate** is a named boolean expression over an event, whose evaluation does not depend on previous events.
   A **predicate** named `s` is declared in the following way:

```
pred s := PREDICATE
```

   The syntax of the `PREDICATE` is the same as the stampers expression, because both constructs are stateless.

2. A **stream** definition is a stream of values calculated as events are fed into the EMS. 
   Streams can be stateful and their values can be **boolean** (`bool`), **numeric** (`num`) or **string**.
   A stream named `s` of type `t` is defined in the following way:

```
stream t s := STREAMEXPR
```

   The syntax of a stream expression is the following:

```
PREDICATE
STREAMID
if STREAMEXPR then STREAMEXPR
Prev STREAMID
e.getstr(PATH)
NUMEXPR
NUMEXPR < NUMEXPR
NUMEXPR <= NUMEXPR
NUMEXPR = NUMEXPR
NUMEXPR > NUMEXPR
NUMEXPR >= NUMEXPR
NUMEXPR != NUMEXPR
```

   Where `NUMEXPR` is defined as:

```
e.getnum(PATH)
NUMEXPR + NUMEXPR
NUMEXPR - NUMEXPR
NUMEXPR * NUMEXPR
NUMEXPR / NUMEXPR
AGGREGATION(STREAMID within STREAMID)
```

   And `AGGREGATION` is one of the following:

```
avg
count
sum
```
<p></p>

   + A `PREDICATE` is true or false for an event just like in the stampers definition.
   + A `STREAMID` refers to a stream declared in this monitoring machine (not necessarily a different one).
   + An `if e0 then e1` expression produces the value specified by the expression `e1` when the expression `e0` evaluates to true.
   + The expression `Prev s` is true if at some point in the past the stream `s` evaluated to `true`.
   + The construct `e.getstr(PATH)` retrieves the string value at path `PATH` of the event.
   + A `NUMEXPR` represents a numeric expression. Its syntax is detailed later on.
   + The constructs `<`, `<=`, `=`, `>`, `>=`, and `!=` compare the values of evaluating both sides of the expression.
   + The construct `e.getnum(PATH)` retrieves the numeric value at path `PATH` of the event.
   + The constructs `+`, `-`, `*`, and `/`, compute a numerical operation on the values of evaluating both sides of the expression.
   + An `AGGREGATION(s0 within s1)` computes an aggregation over the values of the stream `s0`, but only considering those values generated when stream `s1` evaluated to true.
   + The different aggregations that can be computed are the average of the numerical values (`avg`), the sum of the numerical values (`sum`), and counting the events (`count`).

3. A **trigger** is a clause that specifies an action to be performed when a stream produces a true value.
   A **trigger** is declared in the following way:

```
trigger s1 do emit s2 on #ch
```

   In this case, whenever stream `s1` produces a value true, the value of `s2` will be emitted over the channel `#ch`.

<h3 class="holder-subtitle link-top">Example</h3>

Suppose we have a webserver and want to assess that when a client is downloading a file and then a second one starts a download too, then the bandwidth consumption roughly doubles.

The ElasTest infrastructure provides us the means to extract data from the server automatically, and we can use the EMS to organize and process this data according to our desired property.

<h4 class="small-subtitle">The System Under Test</h4>

For this example we will use a well-known webserver, nginx.
The SuT configuration can be seen in the following image:
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ems/sut.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ems/sut.png"/></a>
</div>

The system under test is an ngninx application listening on port `80`, with a file called `sparse` of 500GB in its server root directory.

<h4 class="small-subtitle">The TJob</h4>

The TJob is a custom application whose source code can be found [here](https://github.com/elastest/elastest-monitoring-service/tree/master/e2e-test/tjob), and which has been deployed as a Docker image to Dockerhub at [imdeasoftware/e2etjob](https://hub.docker.com/r/imdeasoftware/e2etjob).

The TJob configuration is the following:

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
