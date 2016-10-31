class ApplicationController < ActionController::Base
  require 'pry'
  before_action :authenticate_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def current_user
      if logged_in?
        session[:login]
      end
    end

    def authenticate_user
 
    	client_id = ENV['GITHUB_CLIENT']
    	redirect_uri = CGI.escape('http://localhost:3000/auth')
    	github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}"
    	redirect_to github_url unless logged_in?
    end

    def logged_in?
    	!!session[:token]
    end
end
