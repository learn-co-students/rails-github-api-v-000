require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
GITHUB_CLIENT_ID  = ENV['d718a7a9cda9d5a352d9']
GITHUB_CLIENT_SECRET  = ENV['21f57f50f472038e36a43e7b8d5f410aefb2730d']

module GithubDemo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
