class SessionsController < ApplicationController

  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
    req.params['client_secret'] = ENV['GITHUB_SECRET']
    req.params['state'] = 'authorization_code'
    req.params['redirect_uri'] = "http://localhost:3000/auth"
    req.params['code'] = params[:code]
  end
 
  body = JSON.parse(resp.body)
  raise resp.inspect
  session[:token] = body["access_token"]
  redirect_to root_path
  end
end