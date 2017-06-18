class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :authenticate_user

private

  def authenticate_user
    redirect_to "http://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_ID']}&scope=repo" unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end

end
