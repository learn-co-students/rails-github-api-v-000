class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      client_id = ENV['CLIENT_ID']
      client_secret = ENV['CLIENT_SECRET']
      # set redirect url and go to github authentication url unless user is logged in
      github_url = "" #set github url
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
