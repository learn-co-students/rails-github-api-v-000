class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}

    token_hash = JSON.parse(resp.body)
    session[:gh_token] = token_hash["access_token"]

    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:gh_token]}", 'Accept' => 'application/json'}

    user_hash = JSON.parse(user_resp.body)
    session[:username] = user_hash['login']

    redirect_to '/'
  end
end
