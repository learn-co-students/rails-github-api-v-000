class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    auth_resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
      # req.params['client_id'] = ENV['GITHUB_CLIENT_KEY']
      # req.params['client_secret'] = ENV['GITHUB_SECRET']
      # req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'
      req.headers['Content-Type'] = 'application/json'
      req.body = {
          client_id: ENV['GITHUB_CLIENT'],
          client_secret: ENV['GITHUB_SECRET'],
          code: params[:code]
      }.to_json
    end

    auth = JSON.parse(auth_resp.body)
    session[:token] = auth['access_token']

    user_resp = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    user = JSON.parse(user_resp.body)
    session[:username] = user['login']

    redirect_to root_path
  end
end
