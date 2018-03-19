class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    # response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
    #   req.params["client_id"] = ENV["GITHUB_CLIENT_ID"]
    #   req.params["client_secret"] = ENV["GITHUB_CLIENT_SECRET"]
    #   req.params["code"] = params[:code]
    #   req.headers['Accept'] = 'application/json'
    # end
    body = JSON.parse(response.body)
    session[:token] = body["access_token"]

    response = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    session[:username] = JSON.parse(response.body)["login"]
    redirect_to root_path
  end
end
