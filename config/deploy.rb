# config valid only for Capistrano 3.1
lock '3.3.5'

set :application, 'cakeside'
set :repo_url, 'git@github.com:cakeside/cakeside.git'
set :branch, 'master'

set :user, "deployer"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git
set :scm_verbose, true

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml .env}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3
#set :normalize_asset_timestamps, false
set :ssh_options, { forward_agent: true }

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.0'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
       invoke 'delayed_job:restart'
    end
    on roles(:web), in: :sequence, wait: 5 do
       invoke 'unicorn:restart'
    end
  end

  desc 'Sync assets'
  task :sync_assets do
    on roles(:web) do
       within release_path do
         with rails_env: fetch(:rails_env) do
           execute :rake, 'assets:sync'
         end
       end
    end
  end

  after :publishing, :sync_assets
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
