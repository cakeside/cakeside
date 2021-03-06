namespace :db do
  task :restore do
    config = Rails.configuration.database_configuration
    destination_db = config[Rails.env]["database"]
    host = config[Rails.env].fetch("host", "localhost")

    newest_backup = Dir['db/backups/*.dump'].max_by { |file| File.mtime(file) }
    sh "PGPASSWORD=#{config[Rails.env]["password"]} pg_restore --verbose --clean --no-acl --no-owner -h #{host} -U #{config[Rails.env]["username"]} -d #{destination_db} #{newest_backup}"
  end

  task :backup do
    sh "bundle exec cap #{ENV['RAILS_ENV']} db:backup"
  end
end
