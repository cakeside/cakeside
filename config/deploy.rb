set :application, "www.cakeside.com"
set :repository,  "git@cakeartist.unfuddle.com:cakeartist/cake.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to, "/home/cakeside/apps/#{application}"

role :web, "ec2-107-22-93-60.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-107-22-93-60.compute-1.amazonaws.com"                         # This may be the same as your `Web` server
role :db,  "ec2-107-22-93-60.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run

set :user, "cakeside"
set :use_sudo, false

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"                              
# require 'bundler/capistrano'
set :rvm_ruby_string, '1.9.2-p290@cakeside'
# set :rvm_type, :user
set :rvm_type, :system
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "amazon-cakeside", "cakeside.pem")] 
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

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
