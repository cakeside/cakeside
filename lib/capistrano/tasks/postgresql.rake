set(:postgresql_host, "localhost")

namespace :postgresql do
  desc "Backup the database and copy it locally"
  task :backup do
    filename = "#{fetch(:rails_env)}-#{Time.now.strftime('%Y-%m-%d-%H-%M')}.dump"
    backup_path = "#{shared_path}/backups"
    ask(:postgresql_password, "default")
    on roles(:db) do
      execute "mkdir -p #{shared_path}/backups"
      execute "PGPASSWORD='#{fetch(:postgresql_password)}' pg_dump -Fc --no-acl --no-owner -h #{fetch(:postgresql_host)} -U deployer cakeside > #{backup_path}/#{filename}"
      download!("#{backup_path}/#{filename}", "db/backups/", :via => :scp)
    end
  end
end
