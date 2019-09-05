<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">ERE with custom code</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

1. Start ElasTest platform:

`docker run --rm -v ~/.elastest:/data -v /var/run/docker.sock:/var/run/docker.sock --rm elastest/platform start -m=singlenode`

2. Use browser to access ElasTest Dashboard.
3. Navigate to Test Engines page and start 'ere'.

**Note:**
The first time you start ERE, you need to wait a couple of minutes for the image to get pulled from ElasTest repository. Once the image is present on your system, starting and stopping ERE is quick. The current size of /elastest/ere-trial image is 4.2 GB (it will be decreased in future releases).

4. Click on eye icon to access ERE UI.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ere-trial/test-engines.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ere-trial/test-engines.png"/></a>
</div>

<h4 class="small-subtitle" id="new_recom">New Recommendation wizard</h4>

Click on 'New Recommendation' button in the main page to enter a description of a test case. In the 'Area Description' field, provide a more general description of the tested area, such as a description of functionality of the class under test. In the 'Task Description' field, indicate the specific task or functionality to be tested. Click OK to submit your query.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ere-trial/enter-query.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ere-trial/enter-query.png"/></a>
</div>

<h4 class="small-subtitle" id="results_page">Results Page</h4>

For each query, ERE produces two types of recommendations: (1) new code generated from the area and task description, and (2) a list of existing test cases retrieved from the software repository based on their similarity to the generated test case.

<h5 class="small-subtitle">Generated code</h5>

The new code inferred by the machine learning model is checked for syntax. If it complies to basic Java syntax rules, it is displayed on the top of the page (embedded into a mock class), otherwise it is skipped.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ere-trial/query_results1.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ere-trial/query_results1.png"/></a>
</div>

<h5 class="small-subtitle">Test cases for reuse</h5>

The list of existing test cases recommended for re-use is displayed in a table. The table provides information that helps to locate the reusable test cases in the repository. Each row includes the name of the class containing the recommended test method and the name of that method, as well as the score indicating the degree of similarity to the generated code.

Click on 'Show Details' link to display the body of the method.

Hover over a class name to view package name.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ere-trial/query_results2.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ere-trial/query_results2.png"/></a>
</div>

Click on the 'Class Members link (if available) to view the members of the class containing the recommended test case.

<div class="docs-gallery inline-block">
    <a data-fancybox="gallery-1" href="/docs/test-services/images/ere-trial/class_members.png"><img class="img-responsive img-wellcome" src="/docs/test-services/images/ere-trial/class_members.png"/></a>
</div>

Click on the 'Repository' link to open the repository of origin and inspect the context of the recommended test case.

<a name="luong"></a> *[1] Luong, T.; Pham, H.; Manning, C.D. Effective Approaches to Attention-based Neural Machine Translation.
In Proceedings of the 2015 Conference on Empirical Methods in Natural Language Processing, Lisbon, Portugal,
17–21 September 2015; pp. 1412–1421*.
