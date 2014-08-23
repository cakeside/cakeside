require 'bundler/capistrano'
require 'dotenv/deployment/capistrano'

load "config/recipes/environments"
load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/delayed_job"
load "config/recipes/monit"
load "config/tasks/utility"
load "config/tasks/rails"

after "deploy", "deploy:cleanup" # remove old releases

require './config/boot'
