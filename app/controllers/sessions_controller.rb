class SessionsController < ApplicationController
  include SessionsHelper 
  skip_before_action :authenticate_user
  def create
  	resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  		req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      	req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      	req.params['code'] = params[:code]
      	req.params['redirect_uri'] = "http://localhost:3000/auth"
      	req.headers['Accept'] = 'application/json'
  	end

  
    body = JSON.parse(resp.body)
  	session[:token] = body["access_token"]
  	redirect_to root_path
  end
  
end