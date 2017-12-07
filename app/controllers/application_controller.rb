class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user
  protect_from_forgery with: :exception

  private
    def authenticate_user
      clint_id = ENV['GITHUB_CLIENT_ID']
      redirect_uri = 'http://localhost:3000/auth'
      github_url = "https://github.com/login/oauth/authorize?client_id=#{clint_id}&redirect_uri=#{redirect_uri}"
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
