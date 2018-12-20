class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']

    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': params['code'] }
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    session[:token] = body['access_token']

     user = Faraday.get "https://api.github.com/user" do |u|
      u.headers['Accept'] = 'application/json'
      u.headers['Authorization'] = 'token ' + session[:token]
     end

    this_user = JSON.parse(user.body)
    # binding.pry
    session[:username] = this_user['login']
    redirect_to root_path
  end
end
