#!/usr/bin/env sh

# abort on errors
set -e

# Get the master branch
git checkout origin/master
git pull

# build
npm run build

# switch to gh-pages
git checkout origin/gh-pages

# clean old build repo
git rm css/* js/*
# copy files
cp -rf dist/* .
# add resources and push to git
git add css/* js/* index.html favicon.ico
git commit -m "Deployment"
git push
