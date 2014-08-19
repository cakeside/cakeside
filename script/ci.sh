#!/bin/bash -x

echo 'bundle install'
bundle install --without production
cp config/database.yml.jenkins config/database.yml
RAILS_ENV=test bundle exec rake ci --trace
