class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT_ID']
      base_url = "https://github.com/login/oauth/authorize"
      url_to_authenticate_with_github = base_url << "?client_id=" << "#{client_id}" << "&scope=repo"
      redirect_to url_to_authenticate_with_github unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
# logged_in? is the truthiness of session[:token]
# A user of my Rails app is considered 'logged-in' to GitHub, i.e., authenticated with GitHub
# if there is a GitHub access token stored inside the session hash
# session[:token] = user's GitHub access token (i.e. will NOT be nil), so the logged_in? method returns true
# However, session[:token] is nil if there is NO access token stored inside the session hash,
# which means the user is NOT logged into (NOT authenticated with) GitHub, so logged_in? returns false

# In authenticate_user, if the user is NOT logged in (i.e. NO access token in session hash),
# we will redirect the user to GitHub to provide their identity.
# The base URL here will be `https://github.com/login/oauth/authorize`
# and will use the Client ID as a parameter.
