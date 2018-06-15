class ApplicationController < ActionController::Base
  before_action :authenticate_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def authenticate_user
      redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['CLIENT_ID']}&scope=repo" if !logged_in?
    end

  def logged_in?
    !!session[:token]
  end
end
