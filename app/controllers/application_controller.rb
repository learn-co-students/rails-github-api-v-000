class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT_ID']
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}"

      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end

end
