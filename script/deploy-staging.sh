#!/bin/bash -x
echo "load bashrc"
source ~/.bashrc

echo 'switch gemset'
rvm use ruby-2.1.1@cakeside --create

echo 'bundle install'
bundle exec rake ci:deploy:staging --trace
