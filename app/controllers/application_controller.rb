class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      if !logged_in?
        client_id = ENV["GITHUB_CLIENT_ID"]
        redirect_uri = CGI.escape("http://159.203.91.59:30009/auth")
        scope = "user repo"
        # prevent cross site attacks
        state = SecureRandom.hex
        session[:github_state] = state

        github_url = "http://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"
        redirect_to github_url
      end
    end

    def logged_in?
      !!session[:token]
    end
end
