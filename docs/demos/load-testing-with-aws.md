<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Load testing with AWS</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<p>An instance of AWS with <a href="https://openvidu.io" target="_blank">Openvidu</a> initiated by the user is used as Sut and a parameterized test is executed whose values must be provided by the user (since they are AWS credentials). The test will start an Openvidu session with three users and check that they are all connected and receiving video and audio from the other users. Once checked, if everything is correct, it will start a second session with 3 other users.</p>

<div class="run-div">
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12">
            <img src="/docs/images/logo-dark.png" style="border: none; padding-top: 14px;" alt="" />
        </div>
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a href="http://live.elastest.io/#/projects/9" target="_blank" class="btn btn-xs btn-primary" title="Try it now">Take a look</a>
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

<h5 class="small-subtitle">Load testing with AWS</h5>

For **execute this TJob** it is necessary carry out the **following steps**:

<h6>Preparing Sut</h6>

-   **Start OpenVidu Sut instance**

It will be necessary to create the instance in CloudFormation with <a href="https://github.com/elastest/demo-projects/blob/master/aws/junit5-qe-openvidu/src/test/resources/openvidu-sut.yml" target="_blank">this file</a>

-   **Set OpenVidu Sut IP**

Once created you must copy the **Public DNS** of the instance. In ElasTest, navigate to the Sut edit page and replace the value of **Sut Ip** field (**`Your OpenviduServer ip here`**) with the Public DNS.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/load-testing-with-aws/sutip.png"><img class="img-responsive img-wellcome" src="/docs/demos/images/load-testing-with-aws/sutip.png"/></a>
</div>

-   **Set AWS Private Key for OpenVidu**

In th same page, replace the value of **Private Key** with your private key

-   **Save the Sut configuration**

Only do click to Save button.

<h6>Preparing TJob</h6>

-   **Edit the TJob to set values to the predefined parameters**

    -   AWS_ACCESS_KEY_ID
    -   AWS_SECRET_ACCESS_KEY
    -   AWS_KEY_NAME
    -   AWS_SSH_PRIVATE_KEY

        The ssh private key must have a specific format: the line breaks must be replaced by the literal character string **`\r\n`**. Example:

            -----BEGIN RSA PRIVATE KEY-----\r\naaaaaaaaaaaaaaaaaaaaaaa\r\nbbbbbbbbbbbbbbbbbbbbbbbb\r\ncccccccccccccccccccccc\r\n-----END RSA PRIVATE KEY-----

    -   AWS_SECURITY_GROUPS

        Security groups shall be established in the following format: **`["GROUP1","GROUP2",...]`**. If only one group is to be established, it must have the same format: **`["GROUP"]`**

        <p></p>

    -   AWS_TAG_SPECIFICATIONS

        Tag specifications must have the following format:

            [ { "resourceType":"instance", "tags":[ {"key":"KEY", "value":"VALUE"} ] } ]

        You can use the following if you want:

            [ { "resourceType":"instance", "tags":[ {"key":"Type", "value":"OpenViduLoadTest"} ] } ]

*   **Activate WebRTC stats (Optional)**

If you want to receive **WebRTC statistics** from browsers, you should check the **`webRtcStats`** checkbox within **EUS** at **Test Support Services**.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/load-testing-with-aws/webrtcstats.png"><img class="img-responsive img-wellcome" src="/docs/demos/images/load-testing-with-aws/webrtcstats.png"/></a>
</div>

-   **Save the TJob**

Only do click to Save button.

<h6>Run TJob</h6>

Just run the TJob and enjoy!

Once the execution is finished, the result will be shown:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/load-testing-with-aws/result.png"><img class="img-responsive img-wellcome" src="/docs/demos/images/load-testing-with-aws/result.png"/></a>
</div>
