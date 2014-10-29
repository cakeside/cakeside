#!/usr/bin/env bash

apt-get update -y
apt-get upgrade -y
apt-get -y install curl git-core python-software-properties imagemagick libmagickwand-dev memcached
apt-get -y install build-essential
apt-get -y install tklib
# Extras for RubyGems and Rails:
apt-get -y install zlib1g-dev libssl-dev
# Readline Dev on Ubuntu 12.04 LTS:
apt-get -y install libreadline-gplv2-dev
# Install some nokogiri dependencies:
apt-get -y install libxml2 libxml2-dev libxslt1-dev
apt-get -y install gawk libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
apt-get -y autoremove
add-apt-repository -y ppa:nginx/stable
apt-get -y update
apt-get -y install nginx
add-apt-repository -y ppa:pitti/postgresql
apt-get -y update
apt-get -y install postgresql-9.3 libpq-dev
add-apt-repository -y ppa:chris-lea/node.js
apt-get -y update
apt-get -y install nodejs
apt-get -y install build-essential
# Packages required for compilation of some stdlib modules
apt-get -y install tklib
# Extras for RubyGems and Rails:
apt-get -y install zlib1g-dev libssl-dev
# Readline Dev on Ubuntu 12.04 LTS:
apt-get -y install libreadline-gplv2-dev
# Install some nokogiri dependencies:
apt-get -y install libxml2 libxml2-dev libxslt1-dev

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.1.3
