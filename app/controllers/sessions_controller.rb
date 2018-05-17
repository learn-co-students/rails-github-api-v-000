class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    #if params[:state] == session[:state]
      response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
        req.params['client_id'] = ENV["GITHUB_CLIENT_ID"]
        req.params['client_secret'] = ENV["GITHUB_CLIENT_SECRET"]
        req.params['code'] = params[:code]
        #req.params["redirect_uri"] = "http://localhost:3000/auth"
        req.params['Accept'] = "application/json"
        #req.params["state"] = session[:state]
      end
      
      binding.pry
      session[:token] = response.body.split(/=|&/)[1]

      redirect_to root_path
    #else
    #  flash[:alert] = "Unable to authenticate user."
    #  redirect_to root_path
   # end
  end
end