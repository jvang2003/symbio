require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Symbio
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set secret cookie token
    config.secret_token = ENV['SECRET_TOKEN']

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # config.time_zone = 'UTC'
    config.time_zone = 'Vienna'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ["de-AT"]
    config.i18n.default_locale = :'de-AT'

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery-1.4.4.min jquery-ui-1.8.7.custom.min rails autocomplete-rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Error handling in views
    require 'action_view'
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      error_class = "fieldWithErrors"
      if html_tag =~ /<(input|textarea|select)[^>]+class=/
        class_attribute = html_tag =~ /class=['"]/
        html_tag.insert(class_attribute + 7, "#{error_class} ")
      elsif html_tag =~ /<(input|textarea|select)/
        first_whitespace = html_tag =~ /\s/
        html_tag[first_whitespace] = " class='#{error_class}' "
      end
      html_tag
    end

    # Disable precompiling assets for Heroku
    config.assets.initialize_on_precompile = false

  end
end
