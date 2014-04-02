#!/usr/bin/env bash

cd /home/vagrant
\curl -L https://get.rvm.io | bash -s stable

source /home/vagrant/.profile
source /home/vagrant/.rvm/scripts/rvm

rvm install 2.1.1
rvm use 2.1.1 --default

#gem source -r http://rubygems.org/
#gem install bundler

source /home/vagrant/.bashrc
source /home/vagrant/.bash_profile
source /home/vagrant/.profile

cd /vagrant
bundle install
