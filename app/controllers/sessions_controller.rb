class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    token_resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV['client_id'], 'client_secret': ENV['client_secret'], 'code': params[:code]}, {'Accept': 'application/json'}
    session[:token] = JSON.parse(token_resp.body)["access_token"]

    user_resp = Faraday.get "https://api.github.com/user", {'Authorization': 'token #{session[:token]}', 'Accept': 'application/json'}
    session[:username] = JSON.parse(user_resp.body)["login"]

    redirect_to root_path
  end
end