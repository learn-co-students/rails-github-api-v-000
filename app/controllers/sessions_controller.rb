class SessionsController < ApplicationController
	skip_before_action :authenticate_user
  def create
  	resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  		req.headers['Accept'] = 'application/json'
  		req.body = {client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET'], code: params[:code]}
	  end
	  body = JSON.parse(resp.body)
	  session[:token] = body["access_token"]

		user_response = Faraday.get "https://api.github.com/user" do |req|
			req.headers['Accept'] = 'application/json'
			req.headers['Authorization'] = "token #{session[:token]}"
		end
		user_info = JSON.parse(user_response.body)
		session[:username] = user_info["login"]
	  redirect_to root_path
  end
end