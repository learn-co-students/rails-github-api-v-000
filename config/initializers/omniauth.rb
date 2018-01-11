Rails.application.config.middleware.use OmniAuth::Builder do

  provider :github, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
