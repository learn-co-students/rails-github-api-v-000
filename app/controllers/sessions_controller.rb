class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers = {"Accept": 'application/json'}
      req.body = {client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET'],
        redirect_uri: "http://localhost:3000/auth", code: params[:code]}
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
    user_info = JSON.parse(user.body)
    session[:username] = user_info["login"]
    redirect_to root_path
  end
end
