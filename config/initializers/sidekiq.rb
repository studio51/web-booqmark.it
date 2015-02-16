if Rails.env == 'development'
  host = ENV['REDIS_SERVER_IP_DEVELOPMENT']
else
  host = ENV['REDIS_SERVER_IP_PRODUCTION']
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:6379" }
end
