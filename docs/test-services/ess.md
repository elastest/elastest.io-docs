<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">ElasTest Security Service (ESS)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

The ElasTest Security Service (ESS) is an ElasTest service for identifying security vulnerabilities in Web applications. ESS creates security tests that mimics the behavior of malicious users to probe a Web application to discover vulnerabilities. ESS is based on [OWASP ZAP](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project), a prominent open source web vulnerability scanner. ESS not only supports the detection of the common web application vulnerabilities such as cross-site scripting, SQL injection etc., but also [replay attacks](https://pdfs.semanticscholar.org/270c/cf24e8be8421515f5121600f248e841f424d.pdf?_ga=2.125276362.151869347.1515086898-1552517986.1515086898) and cross-site script inclusion.

<h3 class="holder-subtitle link-top" id="options">Features</h3>

The current version of ESS (v0.9.1) has the following features.

1. A web-based GUI for providing the details of the Web application under test
2. Support for detecting [common Web application security weaknesses](https://www.owasp.org/index.php/Top_10-2017_Top_10)
3. Supports the detection of insecure cookies that (1) can be stolen using [SSL Stripping attacks](https://paladion.net/ssl-stripping-revisiting-http-downgrading-attacks/), (2) can be stolen using [Cross-Site Scripting attacks](https://en.wikipedia.org/wiki/Cross-site_scripting), (3) facilitates [Cross-Site Request Forgery attacks](https://en.wikipedia.org/wiki/Cross-site_request_forgery)

The future releases of ESS will support the detection of:

1. Vulnerabilities enabling cross-site sctipt inclusion attacks
2. Vulnerabilities enabling replay attacks

<h3 class="holder-subtitle link-top" id="options">Using ESS in a TJob</h3>

ESS can be launched during the execution of a TJob. The following demo explains how this can be done.

Create a new TJob in ElasTest with the following configuration:

-   **TJob name**: **`ESS demo`**,
-   **Current SuT**: Select **`None`**,
-   **Environment Docker Image**: **`dockernash/test-tjob-ess`**
-   **Commands**: 

        python fteaching-tjob.py http://example.org/

-   **Test Support Services**: Check **`EUS`** and **`ESS`**

Save the TJob and click the execute button. The security alerts for the SuT will be displayed under the **`ess section`**.

<h3 class="holder-subtitle link-top" id="options">Basic usage</h3>

<div class="range range-xs-center warning-range">
  <div class="cell-xs-4 cell-lg-1 cell-lg-push-1" style="text-align: center;"><span class="icon mdi mdi-information-outline warning-span"></span></div>
  <div class="cell-xs-8 cell-lg-11 cell-lg-push-11 warning-text"><p><i>This usage is not available in <strong>ElasTest mini mode</strong>.</i></p></div>
</div>

You can scan a web site using ESS. To do this, it is necessary to create an ESS instance first:

1. Start ElasTest and load the Web-GUI the Web browser

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/images/main.png"><img class="img-responsive img-wellcome" src="/docs/images/main.png"/></a>
    </div>

2. Click on the "Test Support Services" side panel option
3. From the drop down list, select "ESS" and click the button "Create Instance"

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/tss_page_ess_selected.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/tss_page_ess_selected.png"/></a>
    </div>

4. Wait until the ESS instance is completely ready

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/loading_ess.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/loading_ess.png"/></a>
    </div>

5. Click on the "View Service Details" icon

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/ess_ready.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/ess_ready.png"/></a>
    </div>

6. Scroll down to see the Web-GUI of ESS

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/1.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/1.png"/></a>
    </div>

7. Enter the URL of the Web site that must be tested using ESS

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/2.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/2.png"/></a>
    </div>

8. Wait until the Spidering and Active Scan completes

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/3.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/3.png"/></a>
    </div>

9. Check the results generated

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/4.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/4.png"/></a>
    </div>

10. Click on each Alert to see the details

    <div class="docs-gallery inline-block">
        <a data-fancybox="gallery-1" href="/docs/test-services/images/ess/5.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ess/5.png"/></a>
    </div>