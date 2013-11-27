set_default :ruby_version, "2.0.0-p353"

namespace :rbenv do
  desc "install rbenv"
  task :install, roles: :app do
    # Install development tools:
    run "#{sudo} apt-get -y install build-essential"
    # Packages required for compilation of some stdlib modules
    run "#{sudo} apt-get -y install tklib"
    # Extras for RubyGems and Rails:
    run "#{sudo} apt-get -y install zlib1g-dev libssl-dev"
    # Readline Dev on Ubuntu 12.04 LTS:
    run "#{sudo} apt-get -y install libreadline-gplv2-dev"
    # Install some nokogiri dependencies:
    run "#{sudo} apt-get -y install libxml2 libxml2-dev libxslt1-dev"

    run "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
    bashrc = <<-BASHRC
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
BASHRC
    put bashrc, "/tmp/rbenvrc"
    run "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
    run "mv ~/.bashrc.tmp ~/.bashrc"
    run %q{export PATH="$HOME/.rbenv/bin:$PATH"}
    run %q{eval "$(rbenv init -)"}
  end
  after "deploy:install", "rbenv:install"

  desc "setup rbenv with ruby and bundler"
  task :setup, roles: :web do
    run "rbenv install #{ruby_version}"
    run "rbenv global #{ruby_version}"
    run "gem install bundler --no-ri --no-rdoc"
    run "rbenv rehash"
  end
  after "deploy:setup", "rbenv:setup"
end
