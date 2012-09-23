namespace :db do
  task :restore do
    dumpfile = "latest"
    config = Rails.configuration.database_configuration
    destination_db = config[Rails.env]["database"]
    puts "restoring to #{destination_db}"
    sh "psql #{destination_db} < #{dumpfile}"
  end
  task :backup do
    sh "cap production backup_db"
    sh "rm -f latest && ln -s db/backups/`ls -rt db/backups/ | tail -n1` latest"
  end
  task :restore_to_staging => :backup do
    sh "cap staging restore_db"
  end
end
