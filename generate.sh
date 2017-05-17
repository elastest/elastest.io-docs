#!/bin/bash

mkdocs build --clean -f mkdocs-web.yml 
git clone https://github.com/elastest/elastest.io.git elastest.io
rsync -av site/ elastest.io/docs/
cd elastest.io/docs
git config user.name "elastestci"
git config user.email "elastestci@gmail.com"
git remote rm origin
git remote add origin https://elastestci:${GH_TOKEN}@github.com/elastest/elastest.io.git

if [[ -z $(git status -s) ]]
then
  echo "Nothing to commit"
else
  git add .
  git commit -m "Deploy from Travis CI"
  git pull origin master
  git push origin master
  echo "Changes has been commited to elastest.io/docs"
fi
