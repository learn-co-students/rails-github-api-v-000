class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}

    resp_hash = JSON.parse(resp.body)
    session[:token] = resp_hash['access_token']

    api_request = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(api_request.body)
    session[:user] = user_json["login"]
    redirect_to root_path
  end
end
