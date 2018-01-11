class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["client_id"], client_secret: ENV["client_secret"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(resp.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end
end
