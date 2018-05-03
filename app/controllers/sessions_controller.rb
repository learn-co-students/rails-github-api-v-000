class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token", :headers => {'Accept'=>'application/json'}) do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['code'] = params[:code]
      req.params['redirect_uri'] = "http://localhost:3000/auth"
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    resp = Faraday.get("https://api.github.com/user", :headers => {'Accept'=>'application/json'}) do |req|
      req.params['oauth_token'] = session[:token]
    end
    body = JSON.parse(resp.body)
    session[:login] = body["login"]
    redirect_to root_path
  end
end
