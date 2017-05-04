servers = ChefSearch.new("production")

role :app, servers.find_by(:app).map { |x| "#{fetch(:user)}@#{x}" }
role :web, servers.find_by(:www).map { |x| "#{fetch(:user)}@#{x}" }
role :db, servers.find_by(:db).map { |x| "#{fetch(:user)}@#{x}" }

set :rails_env, 'production'
set :domain, 'www.cakeside.com'
