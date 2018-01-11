class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token?") do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = ENV['CLIENT_ID']
      req.params['client_secret'] = ENV['CLIENT_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end
    token = JSON.parse(resp.body)['access_token']
    session[:token] = token
    redirect_to root_path
  end
end