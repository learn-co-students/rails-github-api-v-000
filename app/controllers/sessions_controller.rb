class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['code'] = params[:code]
      # req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.headers['Accept'] = "application/json"
    end
    session[:token] = JSON.parse(resp.body)

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]["access_token"]
      req.params['token_type'] = session[:token]["token_type"]
      req.headers['Accept'] = "application/json"
    end
    session[:current_user] = JSON.parse(user_resp.body)
    redirect_to root_path
  end

end