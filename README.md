# Introduction
The elastest.io documentation is generated with [MkDocs](http://www.mkdocs.org). 

You can edit any page or add a new one with a simple text using the Markdown format. When you commit the changes to the repository, the web page will be updated automatically.

# How to add a new page

1. Clone this repository
```
git clone git@github.com:elastest/elastest.io-docs.git
```
2. Go to repository and open docs folder.
3. Create a new Markdown file (.md) into an existent folder. You can create a new document category creating a new folder. The folder name will be category name.
4. Edit that file and add content in [Markdown format](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).
5. If you want to preview the changes in local before commiting, you can execute the following command in the root folder of the repository (you need [Docker] installed) and open the browser in `http://localhost:8000`:

```
docker run -it --rm -v `pwd`:/docs -p 8000:8000 coding2012/mkdocs serve -a 0.0.0.0:8000
```

* In order to preview the complete elastest.io web with the docs integrated:
    * Clone the repo https://github.com/elastest/elastest.io in the same path as elastest.io-docs and serve it with Docker:

    ```
    git clone https://github.com/elastest/elastest.io
    cd elastest.io
    docker run --rm --volume=$PWD:/srv/jekyll -p 4000:4000 -it jekyll/jekyll:3.4.3 jekyll serve 
    ```

    (Run `fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p` to increase the number of files that can be monitored if any problem appears when running this docker container)

    * Run `elastest.io-docs/generate-dev.sh` script, which will build Mkdocs files and will put them in `elastest.io/docs` folder (this is why we need elastest.io and elastest.io-docs repos at the same path). You will need `mkdocs`:

    ```
    sudo apt-get install python-pip
    sudo pip install mkdocs==0.16.3
    ```

    (Append `--user` to the pip command if any problem with permissions)

    * Visit http://localhost:4000 in order to preview elastest.io web with your new documentation integrated. Whenever you update a file in elastest.io-docs/docs folder, you can relaunch generate-dev.sh script to update elastest.io web served by Jekyll's Docker container, listening in localhost:4000)

6. To update the web page, commit and push your changes. [Travis-ci](https://travis-ci.org/elastest/elastest.io-docs/builds/213810417) will generate the HTML and will commit it to [elastest.io repository](https://github.com/elastest/elastest.io). Then, GitHub will update the web [elastest.io/docs](http://elastest.io/docs) automatically.
