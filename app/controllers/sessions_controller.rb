class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
      req.headers = {
              'Accept' => 'application/json'
              }
      req.body = {client_id: ENV['CLIENT_ID']}.to_json
      req.body = {client_secret: ENV['SECRET_KEY']}.to_json
      req.body = {code: params['code']}.to_json
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user_resp = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    user_body = JSON.parse(user_resp.body)
    session[:username] = user_body['login']
    redirect_to root_path
  end
end
