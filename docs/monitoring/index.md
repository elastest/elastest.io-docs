<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Monitoring</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

One of the key features of ElasTest is the ability to **show and analyze logs and metrics** of all elements involved in a test. This is particularly interesting for **end-to-end tests**, which usually involve more complex system architectures in distributed environments. For example, suppose a typical three tier web application with a database. A basic e2e test has the following components: the test itself, web browser (or browsers!), web application and database. All those elements can generate logs and metrics of several types (CPU, memory, network packets…). When a test is executed using ElasTest, the tester can see all that monitoring information in the same graphical user interface and with advanced analysis features.

As stated on [ElasTest core concepts](../../docs#elastest-core-concepts), SuT's, TJob's and TSS's are the modules that ElasTest can monitore and analyse for you. You can gather information and check logs and metrics for any SuT, TJob or TSS.

ElasTest monitoring service is based on **event streams**. Every log and metric entry is called an **event**. The collection of events containing information about the same metric or log is called **event stream**. Any SuT, TJob or TSS can generate multiple event streams. All of them can be gathered and visualized by ElasTest on useful graphs in real time and stored for future reviewing.

ElasTest monitoring service is offered as [Dockerized monitoring](dockerized), [Deployed monitoring](deployed) and [Custom monitoring](custom).
