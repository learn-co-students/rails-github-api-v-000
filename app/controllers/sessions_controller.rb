class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    client_id = ENV['CLIENT_ID']
    client_secret = ENV['CLIENT_SECRET']
    code = params[:code]

    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = ["client_id": client_id, "client_secret": client_secret, "code": code]
      req.headers["Accept"] = 'application/json'
      # ??? WHERE DOES THIS COME FROM?
    end
  end
  
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
  end
end
