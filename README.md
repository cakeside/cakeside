## Environment Setup

Install [rbenv](https://github.com/sstephenson/rbenv#installation)
Install ruby 2.1.2
Install required gems

    bundle install

Setup database (set password to postgres)

    cp config/database.yml.example config/database.yml
    rake db:create:all
    rake db:migrate

Start server

    bundle exec foreman start
    
## Capistrano

    cap staging deploy
    cap production deploy