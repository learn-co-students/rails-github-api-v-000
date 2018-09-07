class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    client_id = ENV["GITHUB_CLIENT_ID"]
    client_secret =  = ENV["GITHUB_CLIENT_SECRET"]
    code = params["code"]

# this is #2 in the flow
#  what's the diff between req.params and req.body and req.headers 
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code' :code } 
      # req.params 


      req.headers['Accept'] = 'application/json'
    end
    body = parse.JSON(response.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end


