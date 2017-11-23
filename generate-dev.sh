mkdocs build --clean -f mkdocs-web.yml
cd ../elastest.io
rm -rf docs
cd ../elastest.io-docs
rsync -av site/ ../elastest.io/docs/
