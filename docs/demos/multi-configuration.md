<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Multi-configuration</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<p>A sample application (backend + db) is started, and a parameterized test is run several times with different parameter values. Logs & metrics are collected and the later are shown together in a comparative graph.</p>

<div class="run-div">
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12">
            <img src="/docs/images/logo-dark.png" style="border: none; padding-top: 14px;" alt="" />
        </div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="http://live.elastest.io:37000/#/projects/5/tjob/36/tjob-exec/53" class="btn btn-xs btn-primary" title="Try it now">Try it now</a>
        </div>
    </div>
    <hr />
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
                        <h4 class="small-subtitle">Recommended system specifications</h4>
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
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12"><img src="/docs/images/amazonAWS.png" style="border: none;" alt="" /></div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="/docs/deploying/aws/" class="btn btn-xs btn-primary" title="Deploy on Amazon">Deploy on Amazon</a>
        </div>
    </div>
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12"><img src="/docs/images/kubernetes.png" style="border: none; max-height: 124px; padding-top: 8px;" alt="" /></div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="/docs/deploying/kubernetes" class="btn btn-xs btn-primary" data-toggle="tooltip" data-placement="button"
                    title="On quarter 3">Deploy on Kubernetes (Q3)</a>
        </div>
    </div>
    <hr />
</div>

<h5 class="small-subtitle">Multi-Configuration TJobs</h5>

For this it is necessary to activate the "multi" option in the TJob creation page, and new Multi-Configuration we add the variable **`BROWSER`** with the values: **`chrome`** and **`firefox`**. This TJob run the test with the chrome browser and after with the firefox.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/multi-configuration/configure.png"><img class="img-responsive img-wellcome" src="/docs/demos/images/multi-configuration/configure.png"/></a>
</div>

When run the TJobs we will see two executions with the values indicates for each, **`chrome`** and **`firefox`**:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/multi-configuration/running.png"><img class="img-responsive img-wellcome" src="/docs/demos/images/multi-configuration/running.png"/></a>
</div>

Then we can see the comparative of the two executions:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/multi-configuration/finish.png"><img class="img-responsive img-wellcome" src="/docs/demos/images/multi-configuration/finish.png"/></a>
</div>