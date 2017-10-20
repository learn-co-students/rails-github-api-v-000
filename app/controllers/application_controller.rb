class ApplicationController < ActionController::Base

  helper_method :logged_in?

  require 'dotenv'

  before_action :authenticate_user
  protect_from_forgery with: :exception

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT_ID']
      redirect_uri = CGI.escape("http://localhost:3000/auth")
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}"
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
