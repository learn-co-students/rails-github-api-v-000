class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'
    end

    token_body = JSON.parse(resp.body)
    session[:token] = token_body["access_token"]

    user = Faraday.get "https://api.github.com/user", {}, {
      'Authorization' => "token #{session[:token]}", 
      'Accept' => 'application/json'
    }
    user_json = JSON.parse(user.body)
    session[:username] = user_json["login"]
    
    redirect_to root_path
  end
end