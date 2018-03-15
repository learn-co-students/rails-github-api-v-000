class SessionsController < ApplicationController
    skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      code: params[:code]
      # req.params['redirect_uri']: "http://localhost:3000/auth"
      }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    body = JSON.parse(resp.body)
    session[:username] = body["login"]

    redirect_to root_path
  end

end
