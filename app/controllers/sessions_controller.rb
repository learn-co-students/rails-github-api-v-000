class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['code'] = params[:code]
      req.params['redirect_uri'] = ENV['GITHUB_CALLBACK_URI']
      req.params['state'] = params[:state]
    end
    
    resp_hash = Rack::Utils.parse_nested_query(resp.body)
    session[:github_token] = resp_hash['access_token']

    user_resp = Faraday.get("#{ENV['GITHUB_API_URL']}/user") do |req|
      req.headers['Authorization'] = "token #{session[:github_token]}"
    end
    user_hash = JSON.parse(user_resp.body)
    session[:username] = user_hash['login']
    
    redirect_to root_path
  end
end