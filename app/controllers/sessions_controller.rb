class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    @resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
      req.headers['Accept'] = 'application/json'
      req.body = {"client_id"=> ENV["GITHUB_CLIENT_ID"], "client_secret"=> ENV["GITHUB_CLIENT_SECRET"], "code"=> params[:code]}
    end 
    parsed_json = JSON.parse(@resp.body)
    session[:token] = parsed_json['access_token']
    redirect_to root_path
  end
end
