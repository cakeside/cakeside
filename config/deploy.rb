require 'bundler/capistrano'
require 'dotenv/deployment/capistrano'

load "config/recipes/environments"
load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/delayed_job"
#load "config/recipes/rvm"
load "config/recipes/rbenv"
load "config/recipes/monit"
load "config/recipes/logrotate"
load "config/tasks/utility"
load "config/tasks/rails"

set :application, "cakeside"
set :user, "deployer"
set :use_sudo, false
default_run_options[:pty] = true # password prompt

# git
set :scm, :git
set :scm_verbose, true
set :repository,  "git@bitbucket.org:cakeside/cakeside.git"
set :branch, "master"
set :deploy_via, :remote_cache

#copy
#set :scm, :none
#set :repository, "."
#set :deploy_via, :copy

set :deploy_to, "/home/#{user}/apps/#{application}"
set :keep_releases, 3
set :normalize_asset_timestamps, false
set :ssh_options, {:forward_agent => true}

after "deploy", "deploy:cleanup" # remove old releases

require './config/boot'
