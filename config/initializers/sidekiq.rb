if Rails.env == 'development'
  host = '127.0.0.1'
else
  host = "redis-gogreen#{Rails.env}.nsvmxn.0001.euw1.cache.amazonaws.com"
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:6379" }
end
