[![Code Climate](https://codeclimate.com/github/mokhan/cakeside/badges/gpa.svg)](https://codeclimate.com/github/mokhan/cakeside)

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
    
## Capistrano

    bundle exec cap staging deploy
    bundle exec cap production deploy
