class SessionsController < ApplicationController
skip_before_action :authenticate_user

	def create

	resp_1 = Faraday.post("https://github.com/login/oauth/access_token") do |req|
		req.headers['Accept'] = 'application/json'
		req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
		req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
		req.params['code'] = params[:code]
		req.params['redirect_uri'] = "http://localhost:3000/auth"
	end

	body_1 = JSON.parse(resp_1.body)
	session[:token] = body_1["access_token"]

	resp_2 = Faraday.get("https://api.github.com/user") do |req|
		req.params['access_token'] = session[:token]
	end

	body_2 = JSON.parse(resp_2.body)
	session[:username] = body_2["login"]
	redirect_to root_path

	end
end