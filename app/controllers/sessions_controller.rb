class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
  	resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  	  req.body = {"client_id"=> ENV["GITHUB_CLIENT"], "client_secret"=> ENV["GITHUB_SECRET"], "code"=> params[:code]}
      # req.params['client_id'] = ENV['GITHUB_CLIENT']
      # req.params['client_secret'] = ENV['GITHUB_SECRET']
      # req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)

    session[:token] = body["access_token"]

    user = Faraday.get("https://api.github.com/user") do |resp|
    	resp.headers['Authorization'] = "token #{session[:token]}"
    	resp.headers['Accept'] = 'application/json'
    end

    user_info = JSON.parse(user.body)
    session[:username] = user_info["login"]


    redirect_to root_path
  end
end
