require 'pry'
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    
    data = {'client_id': client_id, 'client_secret': client_secret, 'code': params[:code]}
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = data
      #req.body['client_id'] = client_id
      #req.body['client_secret'] = client_secret
      #req.body['redirect_uri'] = "http://localhost:3000/auth"
      #req.body['code'] = params[:code]
      req.headers['Accept'] = 'application/json'
    end
    body_hash = JSON.parse(resp.body) 
    session[:token] = body_hash["access_token"]

    results = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    user_hash = JSON.parse(results.body) 
    session[:username] = user_hash["login"]
    redirect_to root_path
  end
end