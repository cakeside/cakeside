Rails.application.config.middleware.use Rack::Attack
# Always allow requests from localhost
# (blacklist & throttles are skipped)
Rack::Attack.safelist('allow from localhost') do |request|
  # Requests are allowed if the return value is truthy
  '127.0.0.1' == request.ip
end

# Throttle requests to 5 requests per second per ip
Rack::Attack.throttle('req/ip', limit: 5, period: 1.second) do |request|
  # If the return value is truthy, the cache key for the return value
  # is incremented and compared with the limit. In this case:
  #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
  #
  # If falsy, the cache key is neither incremented nor checked.
  request.ip
end
