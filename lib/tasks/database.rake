namespace :db do
  task :restore do
    dumpfile = "latest"
    config = Rails.configuration.database_configuration
    destination_db = config[Rails.env]["database"]
    puts "restoring to #{destination_db}"
    sh "psql #{destination_db} < #{dumpfile}"
    #sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{config[Rails.env]["username"]} -d #{destination_db} #{dumpfile}"
  end

  task :backup do
    puts "Please specify RAILS_ENV:"; return unless ENV['RAILS_ENV']
    puts "backup up #{ENV['RAILS_ENV']}"
    sh "cap #{ENV['RAILS_ENV']} postgresql:backup"
  end

  task :restore_to_staging => :backup do
    sh "cap staging postgresql:restore"
  end
end
