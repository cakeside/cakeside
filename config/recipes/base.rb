def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "install all the things"
  task :install do
    run "#{sudo} apt-get -y update", :shell => :bash
    run "#{sudo} apt-get -y install curl git-core python-software-properties imagemagick libmagickwand-dev memcached", :shell => :bash
    run "#{sudo} apt-get -y install build-essential", :shell => :bash
    # Packages required for compilation of some stdlib modules
    run "#{sudo} apt-get -y install tklib", :shell => :bash
    # Extras for RubyGems and Rails:
    run "#{sudo} apt-get -y install zlib1g-dev libssl-dev", :shell => :bash
    # Readline Dev on Ubuntu 12.04 LTS:
    run "#{sudo} apt-get -y install libreadline-gplv2-dev", :shell => :bash
    # Install some nokogiri dependencies:
    run "#{sudo} apt-get -y install libxml2 libxml2-dev libxslt1-dev", :shell => :bash
    run "#{sudo} apt-get -y install gawk libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev", :shell => :bash
    run "#{sudo} apt-get -y autoremove", :shell => :bash
  end
end
