# Introduction
The elastest.io documentation is generated with [MkDocs](http://www.mkdocs.org). You need install MkDocs to generate and view documents locally.
> *Note: It's not necessary install MkDocs to create or modify documentation and commit it. It's only for generate and view it locally. Travis is responsible for generating the documentation and publish in elastest.io repository when you do commit.

# How to add a new document
1. Clone or download repository
2. Go to repository and open docs folder.
3. Create a new Markdown file (.md) into an existent folder or create new folder. The folder name will be category name.
4. Edit that file and add content in markdown format.
5. Open terminal, go to repository and run the following command to generate static documentation into site folder:
	``mkdocs build --clean``
6. Open generated documentation in your browser to view

# How to publish documentation
1. Follow steps 1-4 of "How to add a new document" or edit an existent document file.
2. Commit changes and Travis will deploy and commit it automatically to [elastest.io/docs](http://elastest.io/docs) repository.

>*Note: Don't edit neither mkdocs.yml nor mkdocs-web.yml files. Theme is set automatically (Readthedocs theme in local. Elastest custom theme is setted through Travis on commit for elastest.io web)
