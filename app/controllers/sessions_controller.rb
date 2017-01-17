class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req| 
      req.params['client_id'] = ENV["GITHUB_CLIENT_ID"]
      req.params['client_secret'] = ENV["CLIENT_SECRET"]
      req.params['code'] =  params[:code]
      req.headers['Accept'] = 'application/json'
    end
   access_hash = JSON.parse(response.body)
   session[:token] = access_hash["access_token"]
  
 
    user_resp = Faraday.get("https://api.github.com/user") do |req| 
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    #something wrong here
    user_json = JSON.parse(user_resp.body) 
    session[:username] = user_json["login"] 

    redirect_to root_path
  end
end
