class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    unless logged_in? 
       @response = Faraday.get "https://github.com/login/oauth/authorize" do | headers | 
          headers.params["client_id"] = ENV["client_id"]
          headers.params["redirect_uri"] = "http://67.205.152.27:37124/auth"
       end.to_hash
         
       redirect_to @response[:url].to_s
    end 
        
  end

  def logged_in?
    !session[:login].nil?
  end
end
