class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private
    def logged_in?
      !!session[:token]
    end

    def authenticate_user
      # make sure to pass in the scope parameter (`repo` scope should be appropriate for what we want to do) in step of the auth process!
      client_id = ENV['GITHUB_CLIENT_ID']
      redirect_uri = CGI.escape('http://localhost:3000/auth')
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo&redirect_uri=#{redirect_uri}"
      redirect_to github_url unless logged_in?
    end


end
