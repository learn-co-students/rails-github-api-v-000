class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # binding.pry
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers["Accept"] = 'application/json'
      req.body = {client_id: ENV['GITHUB_CLIENT'], client_secret: ENV['GITHUB_SECRET'],
        code: params[:code]}.to_json
    end

    body = resp.body.to_json
    session[:token] = body["access_token"]

    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = 'token #{session[:token]}'
    end

    user_info = JSON.parse(user.body)
    session[:username] = user_info["login"]
    redirect_to root_path
  end
end
