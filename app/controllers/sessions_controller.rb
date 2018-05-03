class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers = {'Accept' => 'application/json'}
      req.body = {client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET'],
      code: params[:code]}
    end
    #binding.pry
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
    end
    session[:username] = JSON.parse(user_resp.body)['login']

    redirect_to root_path
  end

end
