namespace :deploy do
  desc "deploy to staging server"
  task :staging do
    sh "cap staging deploy:migrations"
    sh "curl http://staging.cakeside.com/ > /dev/null"
  end

  desc "deploy to production server"
  task :production do
    sh "cap production deploy:migrations"
    sh "curl http://www.cakeside.com/ > /dev/null"
  end
end

