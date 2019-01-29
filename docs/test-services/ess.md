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