require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load
module Acrylic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2 
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    if ENV["SMTP_URI"]
      smtp_url = URI.parse(ENV["SMTP_URI"])
      config.action_mailer.smtp_settings = {
        address:   smtp_url.host,
        port:      smtp_url.port,
        user_name: smtp_url.user ? URI.decode_www_form_component(smtp_url.user) : nil,
        password:  smtp_url.password,
        enable_starttls_auto: Rack::Utils.parse_nested_query(smtp_url.query)['tls'].in?(['true', '1', 1, true, 'True', 'TRUE'])
      }
    end

  end
end
