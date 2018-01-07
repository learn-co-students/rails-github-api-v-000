class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'
    end
   
    resp_body = JSON.parse(resp.body)
    session[:token] = JSON.parse(resp.body)["access_token"]
    

    user_resp = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    user_json = JSON.parse(user_resp.body)
    session[:username] = user_json["login"]
    redirect_to '/'

  end


end