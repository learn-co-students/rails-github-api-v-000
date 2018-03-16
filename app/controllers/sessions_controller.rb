class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  
  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}      
      # req.body["client_id"] = ENV["CLIENT_ID"]
      # req.body[:client_secret] = ENV["CLIENT_SECRET"]
      # req.body[:redirect_uri] = "http://localhost:3000/auth" 
      # req.body[:code] = params[:code] 
      # req.headers["Accept"] = "application/json"
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end

end