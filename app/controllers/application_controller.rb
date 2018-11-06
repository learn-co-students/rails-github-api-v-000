class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?
  before_action :authenticate_user

  private

  def authenticate_user
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{client_id}" unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
