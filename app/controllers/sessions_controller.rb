class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create

    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"], code: params[:code] }
      req.headers['Accept'] = 'application/json'
    end
    session[:token] = JSON.parse(response.body)['access_token']

  # resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
  #   req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
  #   req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
  #   req.params['redirect_uri'] = 'http://localhost:3000/auth'
  #   req.params['code'] = params[:code]
    
  #   req.headers = {'Accept': 'application/json'}
  # end
  # session[:token] = JSON.parse(resp.body)['access_token']
  
  
  user_data = Faraday.get('https://api.github.com/user') do |req|
    req.params['access_token'] = session[:token]
    req.headers = {'Accept': 'application/json'}
  end
  session[:username] = JSON.parse(user_data.body)['login']

  redirect_to root_path
end
end
