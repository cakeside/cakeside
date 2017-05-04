require 'chef'
require 'chef-config/workstation_config_loader'

class ChefSearch
  attr_reader :chef_environment

  def initialize(chef_environment = fetch(:chef_env_name))
    @chef_environment = chef_environment
    load_configuration
  end

  def find_by(role, &filter)
    hosts, _, count = search(:node, query_for(role), filter_result: filters)
    hostnames = hostnames_from(hosts, &filter)
    puts "Using #{hostnames.count}/#{count} hosts for role: #{role}"
    hostnames.each { |x| puts "  #{x}" }
    hostnames
  end

  private

  def filters
    { 'fqdn' => ['fqdn'], 'ip' => [ 'ec2', 'public_ipv4' ] }
  end

  def query_for(role)
    [
      "chef_environment:#{chef_environment}",
      "roles:#{role}",
    ].join(" AND ")
  end

  def search(*params)
    Chef::Search::Query.new.search(*params)
  end

  def hostnames_from(hosts, &filter)
    hostnames = hosts.map { |x| x['ip'] }.compact.sort
    if filter.nil?
      hostnames
    else
      hostnames = hostnames.find_all do |hostname|
        yield hostname
      end
    end
  end

  def load_configuration(system_knife_rb = '/etc/chef/client.pem')
    if File.readable?(system_knife_rb)
      puts "Loading chef config from #{system_knife_rb}"
      Chef::Config.from_file(system_knife_rb)
    else
      @loader = ChefConfig::WorkstationConfigLoader.new(nil, nil)
      puts "Loading chef config from #{@loader.config_location}"
      @loader.load
    end
  end
end
