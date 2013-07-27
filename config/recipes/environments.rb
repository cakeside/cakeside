set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
#require 'capistrano/gitflow'
