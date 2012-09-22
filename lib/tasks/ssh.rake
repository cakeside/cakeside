desc "install ssh keys"
task :install_keys do
  sh "cp doc/keys/*.pem ~/.ssh/amazon-cakeside/"
end

namespace :ssh do
  desc "deploy to staging server"
  task :staging do
    sh "ssh ubuntu@ec2-23-22-119-121.compute-1.amazonaws.com -i ~/.ssh/amazon-cakeside/stagingcakesidecom.pem"
  end
end
