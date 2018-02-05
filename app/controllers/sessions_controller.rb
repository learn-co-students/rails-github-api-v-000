class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
     req.body = {
       'client_id': ENV['CLIENT_ID'],
       'client_secret': ENV['CLIENT_SECRET'],
       'code': params[:code]
     }
     req.headers['Accept'] = 'application/json'
  end
  body = JSON.parse(resp.body)
     access_token = body["access_token"]
     session[:token] = access_token

     user_resp = Faraday.get("https://api.github.com/user") do |req|
       req.headers['Authorization'] = "token #{access_token}"
     end

     @user = JSON.parse(user_resp.body)
     session[:username] = @user['login']
     redirect_to root_path
   end
end
