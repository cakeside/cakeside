## Environment Setup

Install RVM

    curl -L https://get.rvm.io | bash -s stable --ruby

Install ruby 2.0.0

    rvm install 2.0.0

Install required gems

    bundle install

Install/Start Postgres

    brew install postgres
    initdb /usr/local/var/postgres

Configure Postgres (uncomment and change unix_socket_directory = '/var/pgsql_socket')

    vim /usr/local/var/postgres/postgresql.conf
    pg-start

Setup database (set password to postgres)

    cp config/database.yml.example config/database.yml
    rake db:create:all
    rake db:migrate

Start server

    rails s
    
## Capistrano

[more info](https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning)

{% highlight text linenos %}

  $ cap deploy:setup
  $ cap deploy:check
  $ cap deploy:update

{% endhighlight %}

