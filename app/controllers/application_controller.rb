class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user

  private

    def authenticate_user
      github_url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&scope=repo"
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
