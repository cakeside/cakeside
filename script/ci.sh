#!/bin/bash -x
echo "load bashrc"
source ~/.bashrc

echo 'switch gemset'
rvm use ruby-2.0.0-p247@cakeside --create

echo 'bundle install'
bundle install --without production
cp config/database.yml.example config/database.yml
xvfb-run bundle exec rake ci --trace
