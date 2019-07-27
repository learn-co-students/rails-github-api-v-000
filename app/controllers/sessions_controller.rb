class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT'], 'client_secret': ENV['GITHUB_SECRET'], 'code': params["code"] }
      #req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
      session[:token] = body['access_token']
      

    user_response = Faraday.get "https://api.github.com/user" do  |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
  
    user = JSON.parse(user_response.body)
      session[:username] = user['login']

    redirect_to '/'
  end
end