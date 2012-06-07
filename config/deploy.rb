#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2-p290@cakeside'
set :rvm_type, :system
#require 'bundler/capistrano'                 # loads RVM's capistrano plugin
set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'capistrano/gitflow'
set :application, "www.cakeside.com"
set :deploy_via, :remote_cache
set :user, "cakeside"
set :password, "password"
set :group, "rvm"
set :use_sudo, false
# set :use_sudo, false
set :deploy_to, "/home/cakeside/apps/#{application}"

set :scm, :git
set :repository,  "git@bitbucket.org:mocheen/cakeside.git"
set :keep_releases, 3
set :branch, "master"
set :deploy_env, 'production'
set :scm_verbose, true

# ugly workaround for bug https://github.com/capistrano/capistrano/issues/81
#before "deploy:assets:precompile", "update_bundler"

# remove old releases
after "deploy", "deploy:cleanup"
