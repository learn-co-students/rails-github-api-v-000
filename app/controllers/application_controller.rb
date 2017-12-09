class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def authenticate_user
      # github_id = ENV['GITHUB_ID']
      # github_url = "https://github.com/login/oauth/authorize?client_id=#{github_id}"
      # redirect_to github_url if logged_in?
      redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo" if !logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
