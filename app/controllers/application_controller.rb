class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

    def authenticate_user
      unless logged_in?
        gh_oauth_base = "https://github.com/login/oauth/authorize"
        client_id_str = "?client_id=#{ENV['GITHUB_CLIENT']}"
        scope_str     = "&scope=repo%20user"
        # redirect_uri  = "&redirect_uri=#{CGI.escape('http://localhost:3000/auth')}"
        redirect_to "#{gh_oauth_base}#{client_id_str}#{scope_str}"
      end
    end

    def logged_in?
      !!session[:token]
    end
end
