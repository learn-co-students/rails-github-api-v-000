class SessionsController < ApplicationController
	skip_before_action :authenticate_user, only: :create

  def create

  	resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_ID"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access = JSON.parse(resp.body)
    session[:token] = access['access_token']

    user = Faraday.get 'https://api.github.com/user', {}, {'Authorization' => 'token #{session[:token]}', 'Accept' => 'application/json'}
    user_json = JSON.parse(user.body)
    session[:username] = user_json['login']

    redirect_to root_path
  end

end