class EnvironmentVariables
  def initialize(configuration = ENV)
    @configuration = configuration
  end

  def [](key)
    @configuration[key]
  end
end
