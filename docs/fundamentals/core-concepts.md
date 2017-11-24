<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Core concepts</h2>
<div class="offset-top-30 offset-md-top-50">
</div>
</div>
</div>

ElasTest is built around three main elements:

- **TJob** (*Test Job*): test to be executed against a piece of software (SuT).
- **SuT** (*Software under Test*): the tested software itself. At the moment, all SuTs must be provided in the form of a Docker container. Dockerized SuT can be specified in two different ways:
    - **Docker image**: SuT is packaged as a single docker image. The name of the image must be specified. If the docker image is not located in DockerHub, then the image name contains the FQDN of the registry.
    - **Docker compose**: SuT is composed by several containers and is defined with a *docker-compose.yml* file.
- **TSS** (*Test Support Services*): services offered by ElasTest to ease the execution and analysis of TJobs. At the moment, only **web browsers** are provided.