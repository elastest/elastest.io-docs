<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Elastest Recommendation Engine (ERE)</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

ElasTest Recommendation Engine (ERE) supports test automation developers by providing two types of recommendations. First, it recommends complete Java implementations of unit test cases based on short descriptions in natural language provided by a tester. Second, it recommends a list of test cases that are most relevant to the test case generated based on user's description.

ERE follows the Neural Machine Translation (NMT) model architecture described in [[1]](#luong), which was designed for the task of performing translation between natural languages. ERE applies the NMT model to the code generation task. It ingests large amounts of data stored in software repositories to learn deep vector representations of source code modules. It then uses these representations to map natural language descriptions to source code (for the first type of recommendations) and to compute the degree of similarity between test cases (for the second type of recommendations).

The trial version includes off-the-shelf model trained on over 700 online source code repositories available on GitHub. To ensure high quality of the code, only most popular repositories (1,000 stars and more) were considered as the source of training data. This Generic Model is capable of generating approximate recommendations, and will be most appropriate for teams that do not have their own training data, i.e. working on new projects with a minimal codebase.

For users who wish to receive very accurate recommendations (requiring little or no editing), and have a medium or large database of automated code relevant to their domain, the best solution is training a custom model. The model trained on users own data will be much more precise without the need for increasing the size. As the part of the trial offering, we will train a project-specific model for users who will directly contact [Innovation Exchange](mailto:iix.elastest@ie.ibm.com).

<h3 class="holder-subtitle link-top">Features</h3>

| Feature                                                | Description                                                                                                                                            |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Recommending new test code                             | Based on short natural language description of a test case, user receives recommended Java implementation of that test case (newly generated code).    |
| Recommending automated test cases for reuse/adaptation | Based on short natural language description of a test case, user receives a list of existing automated test cases that are most relevant to the query. |