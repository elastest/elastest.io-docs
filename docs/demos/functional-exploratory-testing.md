<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Functional / Exploratory testing</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<p>A sample web application (backend + db) is started automatically. The selected browser is started automatically, and all logs and metrics are recorder during the testing session. Alarms are risen when errors are detected in logs.</p>

<div class="run-div">
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12">
            <img src="/docs/images/logo-dark.png" style="border: none; padding-top: 14px;" alt="" />
        </div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="http://live.elastest.io/#/external/projects/2/tjob/2/exec/7" target="_blank" class="btn btn-xs btn-primary" title="Try it now">Try it now</a>
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
                    title="Deploy on Kubernetes">Deploy on Kubernetes</a>
        </div>
    </div>
    <hr />
</div>

<h5 class="small-subtitle">Video <i class="fas fa-video"></i></h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/gifs/functional-testing.gif"><img class="img-responsive img-wellcome" src="/docs/demos/images/gifs/functional-testing.gif"/></a>
</div>