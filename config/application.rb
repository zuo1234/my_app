require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Beijing'
    config.enforce_available_locales = false
    config.i18n.default_locale = "zh-CN"
    config.active_job.queue_adapter = :sidekiq
    
    config.generators do |g|
      g.factory_girl false
      g.helper false
      g.test_framework false
      g.javascripts false
    end
  end
end
