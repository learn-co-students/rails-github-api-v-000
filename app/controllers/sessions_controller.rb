class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['code'] = params[:code]
    end
    body = JSON.parse(resp.body)
    access_token = body["access_token"]
    session[:token] = access_token

    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers = {'Authorization': "token#{session[:token]}", 'Accept': 'application/json'}
    end

    @user_info = JSON.parse(user_resp.body)
    session[:username] = @user_info["login"]
    redirect_to root_path
  end

end
