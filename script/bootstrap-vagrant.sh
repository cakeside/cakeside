#!/usr/bin/env bash

cd /home/vagrant
\curl -L https://get.rvm.io | bash -s stable

source /home/vagrant/.profile
source /home/vagrant/.rvm/scripts/rvm

rvm install 2.0.0
rvm install 1.9.3
rvm use 2.0.0 --default

#gem source -r http://rubygems.org/
#gem install bundler

source /home/vagrant/.bashrc
source /home/vagrant/.bash_profile
source /home/vagrant/.profile
