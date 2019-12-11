<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">ElasTest Big Data Service (EBS)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

The ElasTest Big-Data Service (EBS) is an ElasTest Test Support Service (TSS) that provides a computing engine based on Apache Spark to be utilized by tests inside ElasTest. The ElasTest BigData Service consists of an Apache Spark cluster, the necessary connectors for persistence  services (EDM) and a Rest API to provide detailed health information for the cluster.


<h3 class="holder-subtitle link-top">Example of testing EBS service of ElasTest</h3>

The example described here verifies both the capabilities of both EBS and EDM (ElasTest Data Manager). The scenario of the test is the following

- Download a big textfile from the internet and save it to HDFS (Hadoop Distributed FileSystem) of EDM. 
- Submit the application to Apache Spark. There a word-count application that will return the number of occurrences of every word on the specified file and save the results back in HDFS.
- Pull the result file back out from HDFS. 
- Perform a printout on the result file.

A successful example verifies that a file already stored in EDM could be sent to EBS for some kind of computation, here to count the number of occurrences for each word and finally storing the result in EDM HDFS.

This specific example is a simple shell script executed by “sh” in a docker container. 
First we define the docker image to use

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ebs/01.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ebs/01.png"/></a>
</div>

Then we provide the script commands, which does the following:

- Clones elastest/demo-projects
- Uses maven to build demo-projects/ebs-test
- The script before downloading https://norvig.com/big.txt with wget will remove any previous instance of big.txt
- The result of the word counting computation will be stored in a file called out.txt, any previous instance of out.txt and big.txt are erased from HDFS
- big.txt is sent to HDFS 
- Then it is sent to Spark
- The result file out.txt is produced and it is retrieved from HDFS to be presented 

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ebs/02.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ebs/02.png"/></a>
</div>

The same script with short comments

    # clone from GitHub elastest/demo-projects
    git clone https://github.com/elastest/demo-projects.git
    # go to demo-projects/ebs-test
    cd demo-projects/ebs-test
    # call maven to build the project
    mvn -q package
    # remove big.txt in case it still exists from a previous test
    rm -f big.txt
    # download a new version of big.txt
    wget -q https://norvig.com/big.txt
    # remove old versions of files from HDFS
    hadoop fs -rmr /out.txt 
    hadoop fs -rm /big.txt
    # move the recently downloaded big.txt to HDFS
    hadoop fs -copyFromLocal big.txt /big.txt

    # send big.txt to Spark to run the word count. The result is stored in out.txt
    spark-submit --class org.sparkexample.WordCountTask --master spark://sparkmaster:7077 /demo-projects/ebs-test/target/hadoopWordCount-1.0-SNAPSHOT.jar /big.txt

    # we get the result in out.txt from HDFS
    hadoop fs -getmerge /out.txt ./out.txt
    # present a part of out.txt
    head -20 out.txt

Then we must enable the use of the EBS in a TJob, so we should make sure to tick the corresponding checkbox in the TJob configuration:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ebs/03.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ebs/03.png"/></a>
</div>

Then we declare the Metrics and Logs settings:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ebs/04.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ebs/04.png"/></a>
</div>

After running the test the result and the log of the script appears:

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ebs/05.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ebs/05.png"/></a>
</div>

<h3 class="holder-subtitle link-top">Using APIs to test EBS service of ElasTest</h3>

Below we provide a python scripts to run the test described above. First the script not using the GUI. The script creates and runs a TJob and at the end waits to present the result. In order to run the script below we have to provide the ElasTest URL and the required authentication, for example:

`python e2etest.py http://user_name:password@elastest_host:elastest_port`


    # e2etest.py
    import json
    import requests
    import time
    import sys

    # create a dummy project
    url = sys.argv[1]
    res = requests.get(url)
    data = json.dumps({"id": 666, "name": "EBSE2E"})
    headers = {'content-type': 'application/json'}
    res = requests.post(url+'/api/project', data=data, headers=headers)
    print(res.text)
    print(json.loads(res.text))


    # create a tjob in the project
    COMMANDS = """
    git clone https://github.com/elastest/demo-projects.git
    cd demo-projects/ebs-test
    mvn -q package
    rm -f big.txt
    wget -q https://norvig.com/big.txt
    hadoop fs -rmr /out.txt 
    hadoop fs -rm /big.txt
    hadoop fs -copyFromLocal big.txt /big.txt
    spark-submit --class org.sparkexample.WordCountTask --master spark://sparkmaster:7077 /demo-projects/ebs-test/target/hadoopWordCount-1.0-SNAPSHOT.jar /big.txt
    hadoop fs -getmerge /out.txt ./out.txt
    head -20 out.txt
    """

    tjob=json.dumps({ "id": 0,
    "name": "demotjob",
    "imageName": "elastest/ebs-spark:latest",
    #"sut": '',
    "project": json.loads(res.text),
    "tjobExecs": [],
    "parameters": [],
    # "commands": "git clone https://github.com/elastest/demo-projects.git\r\ncd demo-projects/ebs-test\r\nmvn package\r\nrm -f big.txt\r\nwget https://norvig.com/big.txt\r\n#clean the pre-existing file\r\nhadoop fs  -rmr /out.txt\r\nhadoop fs -rmr /big.txt\r\nhadoop fs -copyFromLocal big.txt /big.txt\r\nspark-submit --class org.sparkexample.WordCountTask --master spark://spark:7077 /demo-projects/ebs-test/target/hadoopWordCount-1.0-SNAPSHOT.jar /big.txt\r\nhadoop fs -getmerge /out.txt ./out.txt\r\nhead -10 out.txt",
    "commands": COMMANDS,
    "esmServicesString": "[{\"id\":\"a1920b13-7d11-4ebc-a732-f86a108ea49c\",\"name\":\"EBS\",\"selected\":true},{\"id\":\"fe5e0531-b470-441f-9c69-721c2b4875f2\",\"name\":\"EDS\",\"selected\":false},{\"id\":\"af7947d9-258b-4dd1-b1ca-17450db25ef7\",\"name\":\"ESS\",\"selected\":false},{\"id\":\"29216b91-497c-43b7-a5c4-6613f13fa0e9\",\"name\":\"EUS\",\"selected\":false},{\"id\":\"bab3ae67-8c1d-46ec-a940-94183a443825\",\"name\":\"EMS\",\"selected\":false}]",
    "esmServices": [
        {
            "id": "a1920b13-7d11-4ebc-a732-f86a108ea49c",
            "name": "EBS",
            "selected": True
        },
        {
            "id": "fe5e0531-b470-441f-9c69-721c2b4875f2",
            "name": "EDS",
            "selected": False
        },
        {
            "id": "af7947d9-258b-4dd1-b1ca-17450db25ef7",
            "name": "ESS",
            "selected": False
        },
        {
            "id": "29216b91-497c-43b7-a5c4-6613f13fa0e9",
            "name": "EUS",
            "selected": False
        },
        {
            "id": "bab3ae67-8c1d-46ec-a940-94183a443825",
            "name": "EMS",
            "selected": False
        }
    ],
    })
    res = requests.post(url+'/api/tjob', headers=headers, data=tjob)
    resjson = res.json()
    tjobid = resjson['id']
    print(resjson['id'])


    # run the tjob
    data = {"tJobParams": []}
    res = requests.post(url + '/api/tjob/' + str(tjobid) + '/exec', headers=headers, json=data)
    print(res.text)


    # probe for results
    # s = requests.Session()
    # exec_resp = s.get(url + "/api/tjob/" + str(tjobid) + "/exec/" + str(json.loads(res.text)["id"]))
    exec_resp = requests.get(url + "/api/tjob/" + str(tjobid) + "/exec/" + str(json.loads(res.text)["id"]))
    print(exec_resp.text)
    execId = json.loads(exec_resp.text)["monitoringIndex"]
    #execId = json.loads(exec_resp.text)["logIndex"]

    TSS_MAX_WAIT = 600 #10 minute max wait time
    while ("FAIL" != str(json.loads(exec_resp.text)["result"]).strip()) and ("SUCCESS" != str(json.loads(exec_resp.text)["result"]).strip()) and (TSS_MAX_WAIT > 0):
        print(("TJob execution status is: "+str(json.loads(exec_resp.text)["result"])))
        exec_resp = requests.get(url + "/api/tjob/" + str(tjobid) + "/exec/" + str(json.loads(res.text)["id"]))
        time.sleep(5)
        TSS_MAX_WAIT = TSS_MAX_WAIT - 5


    # exit successfully
    if "SUCCESS" in str(json.loads(exec_resp.text)["result"]):
        # print exec_resp.text
        print("TJob execution successful")
        # fetch the logs
        res = requests.post(url + '/elasticsearch/' + str(execId) + '/_search?size=8000', headers=headers) 
        reson = json.loads(res.text)
        exit(0)

    # or exit with failure
    elif "FAIL" in str(json.loads(exec_resp.text)["result"]):
        # print exec_resp.text
        print("TJob execution failed")
        print("exit status: " + exec_resp.text)
        # fetch the logs
        res = requests.post(url + '/elasticsearch/' + str(execId) + '/_search?size=8000', headers=headers) 
        reson = json.loads(res.text)
        exit(1)

    elif TSS_MAX_WAIT <= 0: 
        print("timed out waiting for TSS to start")
        exit(1)

Finally the same example using the ElasTest GUI using selenium. 

        from selenium import webdriver
        import time
        import sys
        import selenium

        # TODO: Substitute timers with webdriverwaits.
        url = sys.argv[1]
        projectname = 'deleteme'
        tjobname = 'deletethisproject'
        tjobimage = 'elastest/ebs-spark'
        commands = """
        git clone https://github.com/elastest/demo-projects.git
        cd demo-projects/ebs-test
        mvn -q package
        rm -f big.txt
        wget -q https://norvig.com/big.txt
        hadoop fs -rmr /out.txt 
        hadoop fs -rm /big.txt
        hadoop fs -copyFromLocal big.txt /big.txt
        spark-submit --class org.sparkexample.WordCountTask --master spark://sparkmaster:7077 /demo-projects/ebs-test/target/hadoopWordCount-1.0-SNAPSHOT.jar /big.txt
        hadoop fs -getmerge /out.txt ./out.txt
        head -20 out.txt
        """
        options = webdriver.ChromeOptions()
        options.add_argument('headless')
        driver = webdriver.Chrome(chrome_options=options)
        driver.get(url)

        # Navigate to projects
        # this is normally not necessary, but this method was selected in order to
        # avoid E2E test issues in case the 'New Project' button is removed from the
        # main screen.
        time.sleep(5)
        elemProjects = driver.find_element_by_id('nav_projects')
        if not elemProjects.is_displayed():
            elemMenu = driver.find_element_by_id("main_menu").click()
            time.sleep(1) # delay to allow menu animation to complete.
        elemProjects.click()
        time.sleep(1)

        # create new project
        driver.find_element_by_xpath("//button[contains(string(), 'New Project')]").click()
        driver.find_element_by_name("project.name").send_keys(projectname)
        driver.find_element_by_xpath("//button[contains(string(), 'SAVE')]").click()
        time.sleep(1)

        # create new tjob
        driver.find_element_by_xpath("//button[contains(string(), 'New TJob')]").click()
        time.sleep(5)
        driver.find_element_by_name("tJobName").send_keys(tjobname)
        driver.find_element_by_xpath("//mat-select/div/div/span[contains(string(), 'Select a SuT')]").click()
        driver.find_element_by_xpath("//mat-option/span[contains(string(), 'None')]").click()
        # driver.find_element_by_class_name("mat-select-trigger").click()                  # ugly way of navigating to SuT
        # driver.find_element_by_xpath("//md-option[contains(string(), 'None')]").click()  # but it is mandatory.
        driver.find_element_by_name("tJobImageName").send_keys(tjobimage)
        driver.find_element_by_name("commands").send_keys(commands)
        # driver.find_element_by_xpath("//mat-checkbox[@title='Select EBS']").click()
        driver.find_element_by_xpath("//mat-checkbox[@id='serviceEBS']/label").click()
        # xpath("//*[@id='mat-checkbox-1']/label")).click()
        driver.find_element_by_xpath("//button[contains(string(), 'SAVE')]").click()
        time.sleep(1)

        # run tjob
        driver.find_element_by_xpath("//button[@title='Run TJob']").click()
        time.sleep(10)

        # default wait 10 minutes
        TSS_MAX_WAIT  = 300
        # check for success.
        while TSS_MAX_WAIT > 0:
            try:
                # res = driver.find_element_by_xpath("//etm-dashboard/div[1]/div/md-card/md-card-content/div/span[1]/span[1][ contains(string(), 'SUCCESS') or contains(string(), 'ERROR') or contains(string(), 'FAIL') ]")
                res = driver.find_element_by_xpath("//span/h4[contains(string(), 'SUCCESS') or contains(string(), 'ERROR') or contains(string(), 'FAIL') ]")
                print(res.text)
                break
            except selenium.common.exceptions.NoSuchElementException:
                print("waiting for job to finish")
                time.sleep(20)
                TSS_MAX_WAIT = TSS_MAX_WAIT - 20


        if 'SUCCESS' in res.text:
            print('job succeeded')
            print(res.text)
            exit(0)
        else:
            print('job failed')
            print(res.text)
            exit(1)

        driver.close()


