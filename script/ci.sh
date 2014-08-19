#!/bin/bash -x

echo 'bundle install'
bundle install --without production
cp config/database.yml.jenkins config/database.yml
bundle exec rake ci --trace
