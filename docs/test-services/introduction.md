<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Test Services Introduction</h2>
</div>
</div>

There are two types of Test Services:

-   **Test Support Services (TSSs).** Conceived as services that are enabled on demand, they provide additional functionality that can be used during the execution of a TJob. One instance of these services will be created each time a job is executed.
    -   **[ElasTest User Emulator Service (EUS).](/web-browsers/manual-browsers/)** Service that provides browsers for both manual interaction and automated interacion under the control of tests, by means of starting browsers in containers.
    -   **[ElasTest Device Service (EDS).](/test-services/eds)** Emulates the behaviors of the sensors, actuators and smart devices you need to perform your tests.
    -   **[ElasTest Monitoring Service (EMS).](/test-services/ems)** Service that allows monitoring the execution of the TJobs and SUTs, in a similar way to the normal mode, but with a greater capacity of configuration.
    -   **[ElasTest Bigdata Service (EBS).](/test-services/ebs)** Service that provides a computing engine based on Apache Spark to be utilized by tests inside ElasTest, as well as other ElasTest services. It is disposable, meaning that it can be commissioned/decommissioned on demand and scalable, meaning that it can be resized to provide capacity for faster/bigger calculations. EBS enables ElasTest to easily perform operations on huge datasets being stored locally, in distributed filesystems (HDFS) or remote ones (e.g. Amazon S3).
    -   **[ElasTest Security Service (ESS).](/test-services/ess)** Service that can be used to detect security vulnerabilities in the System Under Test (SuT).

<p></p>

-   **Test Engines(TEs).** Similar to the TSSs with the difference that a single instance of a Test Engine will be used by all the TJobs configured in the platform.
    -   **[ElasTest Cost Engine (ECE).](/test-services/ece)** Service that provides to the users the information to consider the financial of using clouds. Using clouds cost money, in third party clouds you pay for the time and resources you use. As well as in on-premises clouds, you pay for the energy and the hardware resources utilization.
