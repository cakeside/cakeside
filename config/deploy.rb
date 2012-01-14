set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "www.cakeside.com"
set :user, "cakeside"
set :use_sudo, false

set :scm, :git
set :repository,  "git@cakeartist.unfuddle.com:cakeartist/cake.git"
set :deploy_to, "/home/cakeside/apps/#{application}"
set :deploy_via, :remote_cache

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"                              
# require 'bundler/capistrano'
set :rvm_ruby_string, '1.9.2-p290@cakeside'
set :rvm_type, :system

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
