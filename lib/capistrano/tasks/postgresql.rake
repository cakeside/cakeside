set(:postgresql_host, "localhost")
#set(:postgresql_user) { fetch(:application) }
#set(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
#set(:postgresql_database) { "#{fetch(:application)}_#{fetch(:rails_env)}" }

namespace :postgresql do
  desc "Backup the database and copy it locally"
  task :backup do
    on roles(:db) do
      filename = "#{fetch(:rails_env)}-#{Time.now.strftime('%Y-%m-%d-%H-%M')}.dump"
      backup_path = "#{fetch(:shared_path)}/backups"
      run "mkdir -p #{fetch(:shared_path)}/backups"

      ask(:postgresql_password, "default", echo: false)
      run "PGPASSWORD='#{postgresql_password}' pg_dump -Fc --no-acl --no-owner -h #{fetch(:postgresql_host)} -U deployer cakeside > #{backup_path}/#{filename}"
      download("#{backup_path}/#{filename}", "db/backups/", :via => :scp)
    end
  end
end
