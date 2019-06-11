class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    unless logged_in? 
       @response = Faraday.get "https://github.com/login/oauth/authorize" do | headers | 
          headers.params["client_id"] = ENV["GITHUB_CLIENT_ID"]
          headers.params["redirect_uri"] = "#{ENV.fetch("server_address")}/auth"
          headers.params["scope"] = "user"
       end.to_hash
       redirect_to @response[:url].to_s
    end 
  end
  
  def get_access_token
  
  end 

  def logged_in?
    !session[:token].nil? && session[:token] != "redirect_uri_mismatch" && session[:token] != "bad_verification_code"
  end
end
