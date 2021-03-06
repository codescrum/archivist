require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Archivist
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.active_record.schema_format = :sql

    config.assets.paths += %W(#{config.root}/vendor/assets)

    config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff|woff2)$)

    config.autoload_paths += %W(#{config.root}/lib)

    config.enable_dependency_loading = true

    config.action_mailer.delivery_method = (ENV['mailer'] || '').to_sym
    config.action_mailer.postmark_settings = { api_token: ENV['POSTMARK_API_KEY'] }
    config.action_mailer.smtp_settings = {
        address:                ENV['SMTP_ADDRESS'],
        port:                   ENV['SMTP_PORT'],
        domain:                 ENV['SMTP_DOMAIN'],
        user_name:              ENV['SMTP_USERNAME'],
        password:               ENV['SMTP_PASSWORD'],
        authentication:         (ENV['STMP_AUTH'] || '').to_sym,
        enable_starttls_auto:   ENV['STMP_TLSAUTO']
    }
    config.action_mailer.default_url_options = {host: (ENV['HOSTNAME'] || 'localhost')}

    config.after_initialize do
      begin
        if $redis.ping === 'PONG'
          puts 'Redis is connected.'
        else
          raise 'Did not reply "PONG"'
        end
      rescue
        puts 'Redis is NOT connected.'
      end
    end
  end
end
