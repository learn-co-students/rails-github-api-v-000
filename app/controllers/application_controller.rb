class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_user
    client_id = ENV['GITHUB_CLIENT_ID']
    redirect_uri = CGI.escape('http://138.197.214.116:30003/auth')
    github_path = "https://api.github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&allow_signup=false&scope=public_repo"

    redirect_to github_path unless logged_in?
  end

    def logged_in?
      !!session[:token]
    end
end
