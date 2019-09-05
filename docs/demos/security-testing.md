<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Security testing</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<p>It starts a sample vulnerable web application and performs a security pentesting attack to determine the vulnerabilities of the application.</p>

<div class="run-div">
    <hr />
    <div class="row row-run-demo no-margin">
        <div class="col col-md-2 col-sm-4 col-xs-12">
            <img src="/docs/images/logo-dark.png" style="border: none; padding-top: 14px;" alt="" />
        </div>
        <!-- Remove it -->
        <div class="col col-md-8 col-sm-8 col-xs-6">
            <a class="btn btn-xs btn-primary disabled" title="Try it now">Try it now</a>
        </div>
        <div class="col col-md-8 col-sm-8 col-xs-2">
            <span class="text-center"><i class="fas fa-hammer fa-3x"></i>Coming soon</span>
        </div>
        <!--
        <div class="col col-md-10 col-sm-8 col-xs-12">
            <a class="btn btn-xs btn-primary disabled" title="Try it now">Try it now</a>
        </div>
        -->
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

<h5 class="small-subtitle">Test <i class="fab fa-python"></i></h5>

```python
import unittest
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from pprint import pprint
import os
import sys
import requests
from urlparse import urlparse
import time

flag=""
url=""
class PythonOrgSearch(unittest.TestCase):

    def setUp(self):
    	essApiUrl=os.environ['ET_ESS_API']
    	parsed_ess_url=urlparse(essApiUrl)
    	ess_url=parsed_ess_url.scheme+"://"+parsed_ess_url.netloc
    	print("ESS URL is: "+str(ess_url))
    	eusUrl=os.environ['ET_EUS_API']
    	print("EUS URL is: "+str(eusUrl))
    	ess_mitm_proxy_url=ess_url.rstrip(":80").lstrip("http://")
        options = webdriver.ChromeOptions()
        options.add_argument('--proxy-server='+ess_mitm_proxy_url+":8080")
        capabilities = options.to_capabilities()
        self.driver = webdriver.Remote(command_executor=eusUrl, desired_capabilities=capabilities)
	#debug
	#proxies = {'http': ess_mitm_proxy_url+":8080",'https': ess_mitm_proxy_url+":8080"}
	#requests.get('http://example.org', proxies=proxies)

        #self.driver = webdriver.Chrome(desired_capabilities=capabilities)
        #self.driver = webdriver.Firefox()
    def test_search_in_python_org(self):
        driver = self.driver
	essApiUrl=os.environ['ET_ESS_API']
    	parsed_ess_url=urlparse(essApiUrl)
    	ess_url=parsed_ess_url.scheme+"://"+parsed_ess_url.netloc

	if flag == "login":
		driver.get(url)
		login_launch = driver.find_element_by_xpath("//*[@id=\"navigation-bar\"]/div/ul/li[2]/a")
		login_launch.click()
		username = driver.find_element_by_id("email")
		username.send_keys("teacher@gmail.com")
		password = driver.find_element_by_id("password")
		password.send_keys("pass")
		login_btn = driver.find_element_by_id("log-in-btn")
		login_btn.click()
		time.sleep(5)
		settings_btn = driver.find_element_by_id("settings-button")
		settings_btn.click()
		re=requests.post(ess_url+"/ess/api/r4/start/",json={"sites": [url]})
	else:
		if(url=="example"):
			driver.get("https://www.example.org")
			time.sleep(3)
			re=requests.post(ess_url+"/ess/api/r4/start/",json={"sites": ["https://www.example.org"]})
		elif(url=="fullteaching"):
			driver.get("https://52.50.3.12")
			time.sleep(3)
			re=requests.post(ess_url+"/ess/api/r4/start/",json={"sites": ["https://52.50.3.12"]})
		
		
		elif(url==""):					
			driver.get("https://www.example.org")
			time.sleep(3)
			re=requests.post(ess_url+"/ess/api/r4/start/",json={"sites": ["https://www.example.org"]})			
		else:
			driver.get(url)
			time.sleep(3)
			re=requests.post(ess_url+"/ess/api/r4/start/",json={"sites": [url]})	

        #Checking the status of the scan
        if "starting-ess" in re.text:
            req=requests.get(ess_url+'/ess/api/r4/status/')
            status=req.text
            while ("not-yet" in status):
                time.sleep(5)
                req=requests.get(ess_url+'/ess/api/r4/status/')
                status=req.text

    def tearDown(self):
        pass

if __name__ == "__main__":
	if len(sys.argv)>1 and len(sys.argv)<=2:
		url=sys.argv[1]
		del sys.argv[1]
	elif len(sys.argv)>1 and len(sys.argv)>2:
		url=sys.argv[1]
		flag=sys.argv[2]
		del sys.argv[1]
		del sys.argv[1]
	unittest.main()
```

<h5 class="small-subtitle">Generate Report <i class="fas fa-chart-bar"></i></h5>

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/demos/images/security/report.png"><img class="img-responsive img-wellcome" src="/docs/demos/images/security/report.png"/></a>
</div>