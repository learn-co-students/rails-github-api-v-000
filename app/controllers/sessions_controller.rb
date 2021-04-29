class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {
       client_id: ENV["GITHUB_CLIENT_ID"],
       client_secret: ENV["GITHUB_CLIENT_SECRET"],
       code: params[:code]},
     {'Accept' => 'application/json'}
     session[:token] = JSON.parse(resp.body)["access_token"]
      user_details = Faraday.get("https://api.github.com/user") do |req|
       req.headers["Authorization"]= "token #{session[:token]}"
       req.headers["Accept"]='application/json'
     end

     session[:username] = JSON.parse(user_details.body)["login"]
     redirect_to root_path
  end
end
