class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

    def authenticate_user
        if !logged_in?
          redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo"
        end 
    end

    def logged_in?
      !!session[:token]
    end
end
