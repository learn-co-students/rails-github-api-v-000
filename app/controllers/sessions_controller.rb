class SessionsController < ApplicationController
skip_before_action :authenticate_user

	def create

	resp_1 = Faraday.post 'https://github.com/login/oauth/access_token', { client_id: ENV['GITHUB_CLIENT'], client_secret: ENV['GITHUB_SECRET'], code: params[:code] }, { 'Accept': 'application/json' }
	body_1 = JSON.parse(resp_1.body)
	session[:token] = body_1["access_token"]

	resp_2 = Faraday.get("https://api.github.com/user", {}, { Authorization: "token #{session[:token]}" })

	body_2 = JSON.parse(resp_2.body) if resp_2.body != ""
	session[:username] = body_2["login"] if body_2
	redirect_to root_path

	end
end