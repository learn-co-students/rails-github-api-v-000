class SessionsController < ApplicationController
  skip_before_action :authenticate_user

 def create
    @auth_token = Faraday.post "https://github.com/login/oauth/access_token" do | req |
        req.params["client_id"] = ENV["GITHUB_CLIENT_ID"]
        req.params["client_secret"] = ENV["GITHUB_CLIENT_SECRET"]
        req.params["code"] = params[:code]
    end
    
  #  @auth_token = @auth_token.split("&")[0].split("=")[1]
    session[:token] = 1
  
    redirect_to "/"
  end
  
  
  
  def sessions_params
    params.permit(:code, :username)
  end 
end
