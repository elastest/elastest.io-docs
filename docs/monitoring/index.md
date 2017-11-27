<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Monitoring</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

One of the key features of ElasTest is the ability to **show and analyze logs and metrics** of all elements involved in a test. This is particularly interesting for **end-to-end tests**, which usually involve more complex system architectures in distributed environments. For example, suppose a typical three tier web application with a database. A basic e2e test has the following components: the test itself, web browser, web application and database. All those elements can generate logs and metrics of several types (CPU, memory, network packets…). When a test is executed using ElasTest, the tester can see all that monitoring information in the same graphical user interface and with advanced analysis features.

Here we will see how these monitoring features can be used from the tester perspective and how are implemented internally.
