require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookmarkit
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec,
        controller_specs: true,
        model_specs: true,
        helper_specs: true,
        mailer_specs: false,
        feature_specs: true,
        view_specs: false,
        factories_specs: true,
        routing_specs: true,
        request_specs: true

      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('bookmarkit', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # For not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = false

    # Autoload custom libraries and stuff
    config.autoload_paths = %W(#{config.root}/lib/validators)
  end
end
