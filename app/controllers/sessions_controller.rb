class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :Create

  def create

    redirect_uri = CGI.escape("http://localhost:3000/auth")

    resp = Faraday.post("https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT_ID'], redirect_uri: redirect_uri, client_secret: ENV['GITHUB_SECRET'], code: params[:code]}, {'Accept' => 'application/json'})
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]
    user_response = Faraday.get("https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/JSON'})
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    redirect_to root_path
  end
end