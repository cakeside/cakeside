namespace :js do
  task :jasmine, [ :display ] => :environment do |t, args|
    ENV['DISPLAY'] = args[:display] if args[:display]
    sh("bundle exec rake jasmine:ci")
  end

  task :default, [ :display ] => :environment do |t, args|
    Rake::Task['js:jasmine'].invoke(args[:display])
  end
end
