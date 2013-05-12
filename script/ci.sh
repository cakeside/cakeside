#!/bin/bash -x
echo "load bashrc"
source ~/.bashrc

echo 'switch gemset'
#cd .
rvm use 1.9.3@cakeside --rvmrc --create

echo 'bundle install'
bundle install --without production
cp config/database.yml.example config/database.yml
bundle exec rake db:migrate
bundle exec rake spec --trace
