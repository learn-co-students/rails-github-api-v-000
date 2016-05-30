class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
      req.headers['accept'] = 'application/json'
    end

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end

    session[:username] = JSON.parse(user_resp.body)['login']
    session[:token] = JSON.parse(resp.body)['access_token']
    redirect_to root_path
  end
end