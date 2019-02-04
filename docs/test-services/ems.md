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

   A `PREDICATE` is true or false for an event just like in the stampers definition.
   A `STREAMID` refers to a stream declared in this monitoring machine (not necessarily a different one).
   An `if e0 then e1` expression produces the value specified by the expression `e1` when the expression `e0` evaluates to true.
   The expression `Prev s` is true if at some point in the past the stream `s` evaluated to `true`.
   The construct `e.getstr(PATH)` retrieves the string value at path `PATH` of the event.
   A `NUMEXPR` represents a numeric expression. Its syntax is detailed later on.
   The constructs `<`, `<=`, `=`, `>`, `>=`, and `!=` compare the values of evaluating both sides of the expression.
   The construct `e.getnum(PATH)` retrieves the numeric value at path `PATH` of the event.
   The constructs `+`, `-`, `*`, and `/`, compute a numerical operation on the values of evaluating both sides of the expression.
   An `AGGREGATION(s0 within s1)` computes an aggregation over the values of the stream `s0`, but only considering those values generated when stream `s1` evaluated to true.
   The different aggregations that can be computed are the average of the numerical values (`avg`), the sum of the numerical values (`sum`), and counting the events (`count`).

<h5 class="small-subtitle">Example</h5>

For example, if a Stamper is deployed with the following definition:
```
when e.strmatch(type,"net") do #NetData
when e.path(message.info) do #TJobMsg
when e.tag(#testresult) do #websocket 
```
Then, an event stamped with channel **`#testresult`** will also be stamped with channel stamp **`#websocket`**.
An event whose payload is **`{message: {info: "Info"}}`** will be stamped with stamp **`#TJobMsg`** but not with channel stamp **`#NetData`**.
An event whose payload is **`{type: "net", message: "Server"}`** will be stamped with channel stamp **`#NetData`** but not with channel stamp **`#TJobMsg`**.
Finally, an event whose payload is **`{message: {info: "Info"}, type: "net"}`** will be stamped with both channel stamps **`#TJobMsg`** and **`#NetData`**.

