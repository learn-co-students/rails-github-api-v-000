class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create

    access = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      req.body = {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code]}
    end

    body_hash = JSON.parse(access.body)
    session[:token] = body_hash["access_token"]

    results = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    user_hash = JSON.parse(results.body)
    session[:username] = user_hash["login"]
    redirect_to root_path

  end

end
