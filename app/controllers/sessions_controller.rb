class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['code'] = params[:code]
      req.headers['Content-Type'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    # Get user
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]
    end
    user_json = JSON.parse(user_resp.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end
end
