class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # puts "REACHED AUTH CREATE ROUTE!"
    # puts "Params = #{params}"
    
    authResponse = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['client_id']
      req.params['client_secret'] = ENV['client_secret']
      req.params['state'] = 'thisisarandomscopeforauthorization'
      req.params['code'] = params["code"]
      req.headers['Accept'] = 'application/json'
    end
    # puts "AUTH RESPONSE = #{authResponse}"
    # puts "AUTH BODY = #{authResponse.body}"
    auth = JSON.parse(authResponse.body)
    # puts "AUTH = #{auth}"
    # puts "AUTH TOKEN = #{auth['access_token']}"
    session[:token] = auth['access_token']
    redirect_to root_path
  end
end