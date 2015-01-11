unless Rails.env.test?
  ASIN::Configuration.configure do |config|
    config.key           = ENV.fetch('AWS_PRODUCT_KEY')
    config.secret        = ENV.fetch('AWS_PRODUCT_SECRET')
    config.associate_tag = ENV.fetch('AWS_PRODUCT_ASSOCIATE_ID')
  end
  HTTPI.adapter = :curb
  HTTPI.logger  = Rails.logger
end
