class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"] 
 
    user_resp = Faraday.get("https://api.github.com/user") do |req| 
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    user_json = JSON.parse(user_resp.body) 
    session[:username] = user_json["login"] 

    redirect_to root_path
  end
end
