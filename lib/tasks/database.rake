namespace :db do
  task :restore do
    config = Rails.configuration.database_configuration
    destination_db = config[Rails.env]["database"]

    newest_backup = Dir['db/backups/*.dump'].max_by { |file| File.mtime(file) }
    sh "PGPASSWORD=#{config[Rails.env]["password"]} pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{config[Rails.env]["username"]} -d #{destination_db} #{newest_backup}"
  end

  task :backup do
    sh "bundle exec cap #{ENV['RAILS_ENV']} postgresql:backup"
  end

  task :restore_to_staging => :backup do
    sh "bundle exec cap staging postgresql:restore"
  end
end
