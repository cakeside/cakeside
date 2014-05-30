namespace :monit do
  %w[start stop restart syntax reload status].each do |command|
    desc "run monit #{command} script"
    task command do
      run "#{sudo} service monit #{command}"
    end
  end

  task :version do
    run "#{sudo} service monit -V"
  end
end
