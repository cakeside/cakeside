namespace :test do
  task :specs, [ :display ] => :environment do |t, args|
    ENV['DISPLAY'] = args[:display] if args[:display]
    Rake::Task['spec:suite:all'].invoke
  end

  task :jasmine, [ :display ] => :environment do |t, args|
    ENV['DISPLAY'] = args[:display] if args[:display]
    sh("bundle exec rake jasmine:ci")
  end

  task :all, [ :display ] => :environment do |t, args|
    Rake::Task['test:jasmine'].invoke(args[:display])
    Rake::Task['test:specs'].invoke(args[:display])
  end

  task :ci do
    Rake::Task['test:all'].invoke(":99")
  end
end
