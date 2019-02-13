<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">ElasTest Security Service (ESS)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

The ElasTest Security Service (ESS) is an ElasTest service for identifying security vulnerabilities in the System under Test (SuT). ESS creates security tests that probe the SuT to discover security vulnerabilities. ESS is based on [OWASP ZAP](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project) (a prominent open source web vulnerability scanner). ESS not only supports the detection of the common web application vulnerabilities (cross-site scripting, SQL injection etc.), but also cookie misconfigurations, privacy attacks, [replay attacks](https://pdfs.semanticscholar.org/270c/cf24e8be8421515f5121600f248e841f424d.pdf?_ga=2.125276362.151869347.1515086898-1552517986.1515086898), etc.

<h3 class="holder-subtitle link-top" id="options">Features</h3>

The current version of ESS (v1.0.0-beta7) has the following features.
1. Support for programmatically scanning a TJob (see the next section for details)
2. A web-based GUI for keeping track of the progress of a security scan and for displaying the results of a scan
3. Support for detecting [common Web application security weaknesses](https://www.owasp.org/index.php/Top_10-2017_Top_10) that are supported by OWASP ZAP
4. Supports the detection of insecure cookies that are missing 
   - the *secure* flag and thereby allowing [SSL Stripping attacks](https://paladion.net/ssl-stripping-revisiting-http-downgrading-attacks/)
   - the *httponly* flag and therefore susceptible [Cross-Site Scripting attacks](https://en.wikipedia.org/wiki/Cross-site_scripting), 
   - the *SameSite* attribute and thereby facilitating [Cross-Site Request Forgery attacks](https://en.wikipedia.org/wiki/Cross-site_request_forgery)

The future releases of ESS will support the detection of vulnerabilities enabling:
- Privacy Attacks (e.g. Cross-Origin State Inference attacks)
- Replay attacks
- etc.

## Using ESS in a TJob
A normal TJob simply contains the code for executing a test (e.g. executing a selenium test using a web browser provided by the EUS). Once the test has dinished executing, the program returns and the TJob execution is completed. For scan a TJob using ESS, the author of the TJob must add the following steps before exiting.
1. read the value of the *ET_ESS_API* environmental variable to get the URL of the ESS API. The following is an example (in Python) of how this can be done.
```
import os
ess_api_url=os.environ['ET_ESS_API']
```
2. send a HTTP POST request to the path */ess/api/r4/start/* of the ESS API with a JSON body containing the key *sites* with the value being a list of SuT URLs that needs to be scanned for security. The following is an example (in Python) of how this can be done.
```
import requests
resp=requests.post(ess_api_url+"/ess/api/r4/start/",json={"sites": ["https://example.com"]})
```
3. check whether the ESS scan has completed before exiting
```
if "starting-ess" in resp.text:
            resp=requests.get(ess_api_url+'/ess/api/r4/status/')
            status=resp.text
            while ("not-yet" in status):
                time.sleep(5)
                resp=requests.get(ess_url+'/ess/api/r4/status/')
                status=resp.text
```
We have created the docker image of similar TJob and it's code is available [here](https://github.com/avinash-sudhodanan/sample-ess-tjob/blob/master/fteaching-tjob.py). The docker image is available at
> dockernash/test-tjob-ess

## Executing an ESS security scan for a TJob
1. Visit ElasTest GUI in a Web Browser (see example image shown below)
![][Load TORM]
2. Click on the **New Project** button to create a new project (see example image shown below)
![][Create New Project ]
3. Provide a new for the project (see example image shown below)
![][Fill New Project Details]
4. Click on the **New TJob** button to create a new TJob (see example image shown below)
![][Click New TJob]
5. Configure the TJob by providing the details of the docker image of the TJob created (see example image shown below)
![][Configure TJob]
6. Check the checkboxe corresponding to ESS and other requires TSSes (see example image shown below)
![][Check ESS]
7. Click on the play button to run the TJob (see example image shown below)
![][Run TJob]
8. Scroll down to the iframe the ESS GUI is displayed (see example image shown below)
![][Scroll Down to ESS]
9. Wait until the GUI changes to starting the ESS scan (see example image shown below)
![][Start ESS Scan]
10. Notice the progress bar that indicates the progress of the test and the progress status message displayed above (see example image shown below)
![][Completing ESS Scan]
11. Wait until the scan is complete (see example image shown below)
![][Wait to Finish]
12. Click on an alert to expand it (see example image shown below)
![][Expand Each Alert]
13. Scroll up and click on the name of the TJob to go to the TJob menu (see example image shown below)
![][Click to Go Back To TJob]
14. Click on the last TJob execution (see example image shown below)
![][Click on Exected TJob]
15. Look for the *report.json* file that contains the JSON report of the test (see example image shown below)
![][Click on JSON Report]
16. Click on the button next to it to open the JSON report in a new tab (see example image shown below)
![][View JSON Report]

[Load TORM]: /docs/test-services/images/ess/0.png
[Create New Project ]: /docs/test-services/images/ess/1.0.png
[Fill New Project Details]: /docs/test-services/images/ess/1.1.png
[Click New TJob]: /docs/test-services/images/ess/2.png
[Configure TJob]: /docs/test-services/images/ess/3.png
[Check ESS]: /docs/test-services/images/ess/4.png
[Run TJob]: /docs/test-services/images/ess/5.0.png
[Scroll Down to ESS]: /docs/test-services/images/ess/6.0.png
[Start ESS Scan]: /docs/test-services/images/ess/6.1.PNG
[Completing ESS Scan]: /docs/test-services/images/ess/6.2.PNG
[Wait to Finish]: /docs/test-services/images/ess/6.3.PNG
[Expand Each Alert]: /docs/test-services/images/ess/6.4.PNG
[Click to Go Back To TJob]: /docs/test-services/images/ess/7.0.PNG
[Click on Exected TJob]: /docs/test-services/images/ess/7.1.PNG
[Click on JSON Report]: /docs/test-services/images/ess/7.2.PNG
[View JSON Report]: /docs/test-services/images/ess/8.PNG
