class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_user
     redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['d0d5b143f3052a7b0565']}&scope=repo" if !logged_in?
   end

   def logged_in?
     !!session[:token]
   end
end
