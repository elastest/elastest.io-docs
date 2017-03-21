# Local Installation
1. Clone or download repository
2. Install mkdocs
3. Open terminal and go to repository folder
4. Run the following command to generate static documentation into site folder:
> mkdocs build --clean
5. Open generated documentation in your browser to view

# How to add a new document (only for local)
1. Create a new Markdown file into docs folder
2. Open mkdocs.yml file to edit
3. Write in a new line, under 'pages:' line, an array with 3 parameters
    1. Markdown doc file name
    2. Category name
    3. Document title
4. Run the following command to generate static documentation into site folder:
> mkdocs build --clean
5. Open generated documentation in your browser to view

# How to add a new document (For upload to website)
1. Create a new Markdown file into docs folder
2. Open mkdocs-web.yml file to edit
3. Write in a new line, under 'pages:' line, an array with 3 parameters
    1. Markdown doc file name
    2. Category name
    3. Document title
4. Commit and Travis will deploy and commit it automatically to elastest.io/docs repository
