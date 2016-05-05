class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    req.params['client_id'] = ENV['GIT_CLIENT_ID']
    req.params['client_secret'] = ENV['GIT_CLIENT_SECRET']
    req.params['redirect_uri'] = "http://localhost:3000/auth"
    req.params['code'] = params[:code]
    req.headers['Accept'] = 'application/json'
  end
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  session[:username] = body["login"]
  redirect_to root_path
  end



end
