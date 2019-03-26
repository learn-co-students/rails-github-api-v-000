class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
  	resp = Faraday.post "https://github.com/login/oauth/access_token", 
  		{"client_id" => ENV['GITHUB_CLIENT_ID'], 
			"client_secret" => ENV['GITHUB_CLIENT_SECRET'],
			"code" => params[:code],
			"scopes" => "repo",
			"state" => "thisismystate"}, 
  		{"Accept" => 'application/json'}
	session[:token] = JSON.parse(resp.body)["access_token"]

	username_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
	session[:username] = JSON.parse(username_response.body)["login"]

	redirect_to root_path
  end
end
