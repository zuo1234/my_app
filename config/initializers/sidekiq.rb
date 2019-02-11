unless Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: Setting.sidekiq_redis.url, password: Setting.sidekiq_redis.password }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: Setting.sidekiq_redis.url, password: Setting.sidekiq_redis.password }
  end
end