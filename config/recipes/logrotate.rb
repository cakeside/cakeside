namespace :logrotate do
  desc "setup logrotate configuration"
  task :setup do
    template "logrotate.erb", "/tmp/logrotate_conf"
    run "#{sudo} mv /tmp/logrotate_conf /etc/logrotate.d/#{application}"
  end
  after "deploy:setup", "logrotate:setup"
end
