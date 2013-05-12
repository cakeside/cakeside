#!/usr/bin/env bash

apt-get update
apt-get install -y nginx
apt-get install -y imagemagick
apt-get install -y postgresql-9.1
apt-get install -y bash curl git patch bzip2 build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev libcurl3-dev imagemagick libmagickwand-dev libpcre3-dev

su -c 'bash /vagrant/script/bootstrap-vagrant.sh' vagrant
\curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby
