class SessionsController < ApplicationController
  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(resp.body)
    session[:token] = access_hash["access_token"]

    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    session[:username] = JSON.parse(user_resp.body)["login"]
    # raise user_resp.body.inspect
    redirect_to root_path
  end
end
