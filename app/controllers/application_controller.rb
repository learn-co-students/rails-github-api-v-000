class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'dotenv'
  Dotenv.load

  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      client_id = 'a4d3cdd8d8ff49fa54c7'
      redirect_uri = CGI.escape("http://159.203.117.55:3098/auth")
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}"
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
