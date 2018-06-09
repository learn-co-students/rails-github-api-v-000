Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['CLIENT_KEY'], ENV['CLIENT_SECRET']
end