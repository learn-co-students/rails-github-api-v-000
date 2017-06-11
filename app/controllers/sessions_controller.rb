class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # byebug
    resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'

    body = JSON.parse(resp.body)
    session[:token]= body['access_token']

    u_response = Faraday.get 'https://api.github.com/user', {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    u_json = JSON.parse(u_response.body)
    session[:username] = u_json['login']

    redirect_to root_path
  end
end