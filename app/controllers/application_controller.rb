class ApplicationController < ActionController::Base
  before_action :authenticate_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def authenticate_user
    github_url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo"
    redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end