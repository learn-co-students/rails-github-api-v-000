class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  
  def create
  resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['redirect_uri'] = "http://67.205.165.109:54615/auth"
      req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'
   end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    session[:token]
    redirect_to root_path
  end
    
    
    
    
 
end