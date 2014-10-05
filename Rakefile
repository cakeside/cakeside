# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "update the geolite database"
task :geolite do
  sh 'wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
  sh 'gunzip GeoLiteCity.dat.gz'
  sh 'mv -f GeoLiteCity.dat config/GeoLiteCity.dat'
end
