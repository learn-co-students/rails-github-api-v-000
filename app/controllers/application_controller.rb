class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    client_id = ENV['CLIENT_ID']
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo" unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end

# before_action :authenticate_user

#   private

#   def authenticate_user
#     client_id = ENV['PBRIAGWRXB4HHJXCSSUOV54WVNAPHWFGFELKN1J4LBIT0G0Q']
#     client_secret = CGI.escape("http://localhost:3000/auth")
#     code = "https://foursquare.com/oauth2/authenticate?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
#     redirect_to foursquare_url unless logged_in?
#   end

#   client_id	string	Required. The client ID you received from GitHub for your GitHub App.
#   client_secret	string	Required. The client secret you received from GitHub for your GitHub App.
#   code	string	Required. The code you received as a response to Step 1.