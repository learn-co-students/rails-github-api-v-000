class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT']
      redirect_uri = CGI.escape("http://localhost:3000/auth")
      query = "client_id=#{client_id}&redirect_url=#{redirect_uri}"
      github_url = "https://github.com/login/oauth/authorize?#{query}"

      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
