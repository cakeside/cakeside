[![Build Status](https://travis-ci.org/cakeside/cakeside.svg?branch=master)](https://travis-ci.org/cakeside/cakeside)

## Environment Setup

Install [rbenv](https://github.com/sstephenson/rbenv#installation)
Install required gems

    bundle install

Setup database (set password to postgres)

    cp config/database.yml.example config/database.yml
    rake db:create:all
    rake db:migrate

Start server

    bundle exec foreman start
    
## Deployment

    bundle exec cap production deploy
