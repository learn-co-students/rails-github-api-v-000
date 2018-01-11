class SessionsController < ApplicationController
	skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}

    body = JSON.parse(response.body)
    session[:token] = body["access_token"]

    user_response = Faraday.get "https://api.github.com/user" do |req|
      req["Authorization"] = "token #{session[:token]}"
      req["Accept"] = "application/json"
    end
    user_body = JSON.parse(user_response.body)
    session[:username] = user_body['login']
    redirect_to root_path
  end
end