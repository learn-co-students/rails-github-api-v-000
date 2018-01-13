class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.get("https://github.com/login/oauth/authorize") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
