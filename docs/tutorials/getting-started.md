<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Getting started</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

First we will run ElasTest, in the following section we can see the minimum specifications. ElasTest have other forms for deploy, the different types of deployments and options can see in this [link](/try-elastest/).

<div class="run-div">
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12"><img src="/docs/images/docker.png" style="border: none;" alt="" /></div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <div class="row no-margin">
                <div class="col-lg-1 col-md-2 col-sm-2 no-padding">
                    <button id="btn-copy-2" class="btn btn-xs btn-primary" data-toggle="tooltip" data-placement="button"
                    title="Copy to Clipboard">Copy</button>
                </div>
                <div class="col-lg-11 col-md-10 col-sm-10 no-padding">
                    <code id="code-2">docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock elastest/platform start</code>
                </div>
                <br/>
                <div class="row no-margin docker-info-div">
                    <div class="col-lg-1 col-md-2 col-sm-2 no-padding docker-info-icon">
                        <i class="fas fa-info-circle"></i>
                    </div>
                    <div class="col-lg-11 col-md-10 col-sm-10 no-padding">
                        <p class="docker-subtitle">Recommended system specifications</p>
                        <p>ElasTest needs some minimum system specifications in order to run smoothly:</p>
                        <table>
                            <tr>
                                <td>Processor</td>
                                <td>1GHz or faster</td>
                            </tr>
                            <tr>
                                <td>RAM</td>
                                <td>16GB</td>
                            </tr>
                            <tr>
                                <td>SWAP</td>
                                <td>4GB (if RAM < 16GB)</td>
                            </tr>
                            <tr>
                                <td>Hard Disk</td>
                                <td>30GB</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

ElasTest contains by default different example Tests, we will use this Tests for the examples in the different tutorials.

<h4 class="holder-subtitle link-top">Running the "JUnit5 Rest Test" TJob</h4>

There will be a "Rest Api" sample project available on the dashboard (among others) so users can quickly run their first test. To do so:

<h5 class="small-subtitle">1. Access your ElasTest dashboard</h5>
<p>In this place we can see all projects, TJob running, TJob finished as well as the menu with the differents sections.</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/dashboard.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/dashboard.png"/></a>
</div>

<h5 class="small-subtitle">2. Get into "Rest Api" project</h5>
<p>If we click in the name of the project we will go to the page with the TJobs of the project.</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/select-proyect.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/select-proyect.png"/></a>
</div>

<h5 class="small-subtitle">3. We can see dashboard of the project </h5>
<p>Besides the play of the TJobs we will can edit, copy and delete them.</p>
<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/proyects.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/proyects.png"/></a>
</div>

<h5 class="small-subtitle">4. Run the 'JUnit5 Rest Test' TJob</h5>
<p>We can play the test pressing the play button. The button is show in the next image:</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/run-test.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/run-test.png"/></a>
</div>

<h5 class="small-subtitle">5. Execution screen is open automatically</h5>

<p>Our TJob will start running: you will see the test information and log.</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/running.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/running.png"/></a>
</div>

<p>Once the test is finished you will see the test results and log. Eventually the test should end succesfully.</p>

<p>
    <div class="range range-xs range-xs-center warning-range">
        <div class="cell-xs-2 cell-lg-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
        <div class="cell-xs-10 cell-lg-11 warning-text"><p><i>IMPORTANT: ElasTest make use of  <a href="/docs/testing/unit#xmlAndtestResultsPath" title="View XML Report explanation">xml results file</a> to get all the test results information.</i></p></div>
    </div>
</p>

<p>You can also click on one of them to navigate to the information section of this Test Case, where you can see their logs filtered thanks to the two traces of logs that the class ElasTestBase prints at the beginning and end of each test and that we have commented above. There's only one in this TJob, so we'll navigate to this one (rootServiceTest):</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/results.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/results.png"/></a>
</div>

<p>If we would like see other logs we can select this logs in this section:</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/select-logs-to-show.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/select-logs-to-show.png"/></a>
</div>

<h5 class="small-subtitle">6. Show metrics</h5>

<p>We can show metrics of the test executions for different components. We select them in this button:</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/results-select-metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/results-select-metrics.png"/></a>
</div>

<p>We select the metrics that like view and push 'Apply and Save':</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/select-metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/select-metrics.png"/></a>
</div>

<p>We can see the selected metrics in the bottom of the page</p>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/tutorials/images/getting-started/metrics.png"><img class="img-responsive img-wellcome" src="/docs/tutorials/images/getting-started/metrics.png"/></a>
</div>
