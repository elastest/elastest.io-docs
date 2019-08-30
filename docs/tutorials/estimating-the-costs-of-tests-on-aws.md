<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Estimating the costs of tests on AWS</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest Cost Engine (ECE) enables you to estimate the cost of executing your tests over ElasTest platform. Additionally, once the tests have finished execution, ECE allows you to see a detailed breakup of true cost across all physical and virtual resources used by various test execution runs.

<h3 class="holder-subtitle link-top">Staring up the engine</h3>

Before the cost engine can be used, it has to be started. Click on the play button next to ece in the Test Engines panel in ElasTest dshboard.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/engines.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/engines.png"/></a>
</div>

Wait for the engine to be properly initialized, once it is ready, you will see the view icon just before the trash icon.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/img02.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/img02.png"/></a>
</div>

Click on the view icon to access the ece dashboard.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/img03.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/img03.png"/></a>
</div>

The ece fetches the list of all registered TJobs in ElasTest and presents a very simple interface with only 2 options next to each registered TJob. 

Analyze button allows one to estimate the cost of running a test based on the user's self asessment of the duration of the test and usage of various infrastructure and/or support service resources.

True Cost button fetches the list of all known executions of the selected TJob, and using the actual resources consumed which it fetches from the ElasTest Monitoring Platform (EMP) service, computes the true cost of executions.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/img04.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/img04.png"/></a>
</div>

<h3 class="holder-subtitle link-top">Estimating the cost of test execution</h3>

In order to estimate the cost of execution of your tests, click on the Analyze button next to your registered TJob id. You will be shown a form depending on the test support services you have selected while registering your TJob definition in the ElasTest dashboard.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/img05.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/img05.png"/></a>
</div>

In the figure above, the form displays fields where you can enter expected consumption of resources your TJob will need during execution. This form is dynamically generated based on the selected support services for the TJob and the registered cost models for the corresponding services in the ElasTest Service Manager (ESM). Please fill in reasonable values and hit Submit Data button at the bottom of the page.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/img06.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/img06.png"/></a>
</div>

The cost engine does static estimation based on the entered values and shows back the result in a easy to understand graphic. An example response screen is shown below.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/img07.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/img07.png"/></a>
</div>

The result shows the following data -

* summary of cost models of underlying infrastructure use, and any support service selected for use with TJob.
  * setup cost: a one time cost component applied everytime this service is created for use with TJob
  * meter list: list of parameters based on which the customer is billed
* Breakup of usage data
  * This is derived from the data entered in the previous form
* Cost estimate breakup
  * Pie chart with breakup of overall cost between consitituents

This stage should provide the user a fairly detailed estimate of cost of executing their TJobs with ElasTest.

<h3 class="holder-subtitle link-top">Finding the true cost of test runs</h3>

For computing the true cost of your current and past test executions, simply click the **True Cost** button next to your registered TJob.

The service fetches the list of ongoing and past executions, gather all necessary usage data aggregates from the ElasTest EMP service, and applies the appropriate cost models after fetching them from ESM service.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ece/img08.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ece/img08.png"/></a>
</div>