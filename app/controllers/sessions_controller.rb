class SessionsController < ApplicationController
	skip_before_action :authenticate_user
  def create
  	resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  		req.params['client_id'] = ENV['client_id']
  		req.params['client_secret'] = ENV['client_secret']
  		req.params['code'] = params['code']
  		req.headers[:Accept] = "application/json"
  	end
  	body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end