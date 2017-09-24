Rails.application.config.middleware.use Rack::Cors do
  allow do
    origins "*"
    resource "/api/v2/*", headers: :any, methods: [:get, :post, :put, :delete, :options]
    resource "/api/v2/*/*", headers: :any, methods: [:get, :post, :put, :delete, :options]
  end
end
