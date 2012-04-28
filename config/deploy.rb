
set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "www.cakeside.com"
set :user, "cakeside"
set :password, "password"
set :group, "rvm"
# set :use_sudo, false

set :scm, :git
set :repository,  "git@cakeartist.unfuddle.com:cakeartist/cake.git"
set :deploy_to, "/home/cakeside/apps/#{application}"
set :deploy_via, :remote_cache
set :deploy_env, 'production'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"                              
require 'bundler/capistrano'                 # loads RVM's capistrano plugin
set :rvm_ruby_string, '1.9.2-p290@cakeside'
set :rvm_type, :system
