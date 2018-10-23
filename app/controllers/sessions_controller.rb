class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"] #set the session

    user_resp = Faraday.get("https://api.github.com/user") do |req|
  		req.headers["Authorization"] = "token #{session[:token]}"
  		req.headers["Accept"] = "application/json"
  	end

    user = JSON.parse(user_resp.body)
    session[:username] = user["login"]
    redirect_to root_path
  end
end
