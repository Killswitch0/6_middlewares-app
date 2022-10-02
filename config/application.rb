require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MiddlewaresApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Если какая-то из middleware нам не нужна, мы можем её удалить
    # config.middleware.delete ActionDispatch::Session::CookieStore

    # Для замены порядковой позиции
    config.middleware.swap ActionDispatch::RequestId, ActiveRecord::Migration::CheckPending
  end
end
