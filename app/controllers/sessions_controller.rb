class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.body = {
        :client_id => ENV['GITHUB_CLIENT_ID'],
        :client_secret => ENV['GITHUB_CLIENT_SECRET'],
        :code =>  params['code'],
      }
      req.headers['Accept'] = "application/json"
     end
     access_token = JSON.parse(resp.body)['access_token']
     session[:token] = access_token

     resp = Faraday.get('https://api.github.com/user') do |req|
       req.headers['Authorization'] = "token #{access_token}"
       req.headers['Accept'] = "application/json"
     end
     user = JSON.parse(resp.body)
     session[:username] = user['login']
     redirect_to root_path
  end
end
