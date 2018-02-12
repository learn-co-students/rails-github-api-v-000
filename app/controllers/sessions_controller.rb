class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/authorize") do |req|
      req.params['client_id'] = ENV['GITHUB_OAUTH_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_OAUTH_CLIENT_SECRET']
      req.params['code'] = params[:code]
      req.params['redirect_uri'] = "http://localhost:3000/auth"
    end
    response = resp.to_json
    body = JSON.parse(response)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
