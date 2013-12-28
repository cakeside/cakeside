## Environment Setup

Install RVM

    curl -L https://get.rvm.io | bash -s stable --ruby

Install ruby 2.0.0

    rvm install 2.0.0

Install required gems

    bundle install

Setup database (set password to postgres)

    cp config/database.yml.example config/database.yml
    rake db:create:all
    rake db:migrate

Start server

    rails s
    
## Capistrano

[more info](https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning)

    cap staging deploy:migrations
    cap production deploy:migrations

