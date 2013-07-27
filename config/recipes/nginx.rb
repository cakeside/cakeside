namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install, roles: :web do
    run "#{sudo} add-apt-repository -y ppa:nginx/stable"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nginx"
  end
  after "deploy:install", "nginx:install"

  desc "setup nginx configuration"
  task :setup, roles: :web do
    run "#{sudo} rm -f /tmp/nginx_conf"
    run "#{sudo} rm -f /etc/nginx/sites-available/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/#{application}"

    template "nginx_unicorn.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-available/#{application}"
    run "#{sudo} ln -s /etc/nginx/sites-available/#{application} /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
  end
  after "deploy:setup", "nginx:setup"

  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command, roles: :web do
      run "#{sudo} service nginx #{command}"
    end
  end
end
