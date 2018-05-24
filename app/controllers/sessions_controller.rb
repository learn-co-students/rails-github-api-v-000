class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create
  def create
  	resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
	  	req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
	    req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
	    req.params['code'] = params[:code]
	    req.headers['Accept'] = 'application/json'
	end

	body = JSON.parse(resp.body)
	session[:token] = body['access_token']

	user_info = Faraday.get("https://api.github.com/user") do |req|
		req.headers['Authorization'] = "token #{session[:token]}"
		req.headers['Accept'] = 'application/json'
	end
	user_body = JSON.parse(user_info.body)
	session[:username] = user_body['login']
	redirect_to root_path
  end

end