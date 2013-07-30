set_default(:delayed_job_pid) { "#{shared_path}/pids/delayed_job.pid" }

namespace :delayed_job do 
  desc "setup delayed job"
  task :setup, roles: :app do
    template "delayed_job_init.erb", "/tmp/delayed_job_init"
    run "chmod +x /tmp/delayed_job_init"
    run "#{sudo} mv /tmp/delayed_job_init /etc/init.d/delayed_job_#{application}"
    run "#{sudo} update-rc.d -f delayed_job_#{application} defaults"
  end
  after "deploy:setup", "delayed_job:setup"

  %w[start stop restart].each do |command|
    desc "#{command} delayed_job"
    task command, roles: :app do
      run "#{sudo} service delayed_job_#{application} #{command}"
    end
    after "deploy:#{command}", "delayed_job:#{command}"
  end
end
