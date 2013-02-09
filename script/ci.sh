#!/bin/bash -xl
source ~/.bashrc
cd .
bundle install --without production
cp config/database.yml.example config/database.yml
#rake db:schema:load
bundle exec rake db:migrate
bundle exec rake spec --trace
