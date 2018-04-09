class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    oauth_resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.headers = {'Accept' => 'application/json'}
      req.body = {
        'client_id' => ENV['GITHUB_CLIENT_ID'],
        'client_secret' => ENV['GITHUB_CLIENT_SECRET'],
        'code' => params[:code]
      }
    end
    oauth_body = JSON.parse(oauth_resp.body)
    session[:token] = oauth_body["access_token"]

    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    user_body = JSON.parse(user_resp.body)
    session[:username] = user_body["login"]

    redirect_to root_path
  end
end