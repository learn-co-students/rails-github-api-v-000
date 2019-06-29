class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  
  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    # resp = Faraday.post "https://github.com/login/oauth/access_token",  {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: params[:code]},
    # {'Accept'=>'application/json'}
    # end
    # body = JSON.parse(resp.body)
    # session[:token] = body["access_token"]


    # user_response = Faraday.get ("https://api.github.com/user") do |req|
    #   req.headers['Authorization'] = "token #{session[:token]}"
    #   ['Accept'] = 'application/json'
    # user_json = JSON.parse(user_response.body)
    # session[:username] = user_json["login"]
    
    redirect_to root_path
  # end
end
