namespace :nodejs do
  desc "install node.js"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository -y ppa:chris-lea/node.js"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nodejs"
  end
  after "deploy:install", "nodejs:install"
end
