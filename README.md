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

    bundle exec cap staging deploy
    bundle exec cap production deploy

## Git Workflow





## Run tests




## Creating and restoring from backups



## Sync logs to S3




