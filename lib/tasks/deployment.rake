namespace :deploy do
  desc "deploy to staging server"
  task :staging => :spec do
    sh "cap staging deploy:migrations"
    sh "curl http://staging.cakeside.com/ > /dev/null"
  end
  desc "deploy to production server"
  task :production, :tag do |t, args|
    tag_to_deploy = args.tag
    if tag_to_deploy.blank?
      #puts "please specify the name of the tag to deploy"
      #puts "E.g. rake deploy:production['staging-2012-06-02-1-mo-user-settings']"
      sh "cap production deploy:migrations"
    else
      puts "deploying to production from tag #{tag_to_deploy}"
      sh "cap production deploy:migrations -s tag=#{tag_to_deploy}"
      #sh "cap production deploy -s tag=#{tag_to_deploy}"
      #sh "cap production deploy:migrations"
      sh "curl http://cakeside.com/ > /dev/null"
    end
  end
end
