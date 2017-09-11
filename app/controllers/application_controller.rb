class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT']
      # client_secret = ENV['CLIENT_SECRET']
      redirect_uri = CGI.escape("http://159.203.80.114:30001/auth")
      github_url = "http://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=public_repo"
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
