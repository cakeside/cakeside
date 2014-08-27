namespace :nginx do
  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command do
      on roles(:web) do
        execute :sudo, "service nginx #{command}"
      end
    end
  end
end
