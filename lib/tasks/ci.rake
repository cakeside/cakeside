task :ci => ['db:test:prepare', 'spec', 'js:default']
