class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def oauth_redirect_url
      "http://localhost:3000/auth"
    end

    def authenticate_user
      # make sure to pass in the scope parameter (`repo` scope should be appropriate for what we want to do) in step of the auth process!
      # https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/#web-application-flow
      client_id = CGI.escape(ENV['GITHUB_CLIENT_ID'])
      redirect_uri = CGI.escape(oauth_redirect_url)
      github_auth_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo&redirect_uri=#{redirect_uri}"
      redirect_to github_auth_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
