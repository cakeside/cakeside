#!/bin/bash -x
git checkout master
bundle exec rake ci:deploy:production --trace
