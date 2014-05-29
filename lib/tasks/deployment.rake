namespace :deploy do
  desc "deploy to staging server"
  task :staging do
    sh "bundle exec cap staging deploy:migrations"
    sh "curl https://staging.cakeside.com/ > /dev/null"
  end

  desc "deploy to production server"
  task :production do
    sh "bundle exec cap production deploy:migrations"
    sh "curl https://www.cakeside.com/ > /dev/null"
  end
end

