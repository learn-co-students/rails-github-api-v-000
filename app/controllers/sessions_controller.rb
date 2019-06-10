class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    @auth_token = Faraday.get "https://github.com/login/oauth/access_token" do | req |
        req.params["client_id"] = ENV["client_id"]
        req.params["client_secret"] = ENV["client_secret"]
        req.params["code"] = params[:code]
        req.params['redirect_uri'] = "#{ENV.fetch("server_address")}/auth"
    end.body
    @auth_token = @auth_token.split("&")[0].split("=")[1]
    session[:token] = @auth_token
  
    redirect_to "/"
  end
  
  
  def sessions_params
    params.permit(:code, :username)
  end 
end
