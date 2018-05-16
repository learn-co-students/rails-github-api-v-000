class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post 'https://github.com/login/oauth/access_token', {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
    body_hash = JSON.parse(resp.body)
    session[:token] = body_hash["access_token"]

    access_token_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    next_body_hash = JSON.parse(access_token_resp.body)
    session[:username] = next_body_hash["login"]

    redirect_to root_path
   end
 end
