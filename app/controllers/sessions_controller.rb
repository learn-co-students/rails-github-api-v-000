class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    #binding.pry
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_SECRET']
    code = params[:code]
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { "client_id": client_id, "client_secret": client_secret, "code": code }
      req.headers["Accept"] = 'application/json'
    end
    #binding.pry
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    #binding.pry
    redirect_to '/'
  end
end
