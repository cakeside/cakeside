require "rvm/capistrano"
set :rvm_ruby_string, :local
set :rvm_autolibs_flag, :enable
set :rvm_type, :user
set :default_shell, :bash

after "deploy:install", "rvm:install_rvm"
after "deploy:install", "rvm:install_ruby"
