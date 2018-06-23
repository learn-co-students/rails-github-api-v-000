class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {'client_id': ENV['CLIENT_ID'],'client_secret': ENV['CLIENT_SECRET'], 'code': params[:code]}, {'Accept': 'application/json'}
    token = JSON.parse(resp.body)
    session[:token] = token["access_token"]

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    user_resp = JSON.parse(user_resp.body)
    session[:username] = user_resp["login"]
  
    redirect_to root_path
  end
end

  # user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}