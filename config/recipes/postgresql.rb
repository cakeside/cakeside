set_default(:postgresql_host, "localhost")
set_default(:postgresql_user) { application }
set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
set_default(:postgresql_database) { "#{application}_#{rails_env}" }
set_default(:postgresql_pid) { "/var/run/postgresql/9.2-main.pid" }

namespace :postgresql do
  desc "install the latest release or postgresql"
  task :install, roles: :db, only: { primary: true } do
    run "#{sudo} add-apt-repository -y ppa:pitti/postgresql"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install postgresql-9.2 libpq-dev"
  end
  after "deploy:install", "postgresql:install"

  desc "create a database"
  task :create_database, roles: :db, only: { primary: true } do
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  end
  after "deploy:setup", "postgresql:create_database"

  desc "generate database.yml"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "postgresql:setup"

  desc "symlink the database.yml file into the latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "postgresql:symlink"

  desc "Backup the database and copy it locally"
  task :backup, roles: :db, only: {primary: true} do
    filename = "#{rails_env}-#{Time.now.strftime('%Y-%m-%d-%H-%M')}.dump"
    backup_path = "#{shared_path}/backups"
    run "mkdir -p #{shared_path}/backups"

    #run "PGPASSWORD='#{postgresql_password}' pg_dump -Fc --no-acl --no-owner -h #{postgresql_host} -U #{postgresql_user} #{postgresql_database} > #{backup_path}/#{filename}"
    run "PGPASSWORD='#{postgresql_password}' pg_dump -Fc --no-acl --no-owner -h #{postgresql_host} -U deployer cakeside > #{backup_path}/#{filename}"
    download("#{backup_path}/#{filename}", "db/backups/", :via => :scp)
  end
end
