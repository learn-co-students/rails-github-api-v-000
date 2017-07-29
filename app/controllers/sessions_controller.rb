class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    #  resp = Faraday.post"https://github.com/login/oauth/access_token", 
    #   {client_id: ENV["GH_BASIC_CLIENT_ID"], client_secret: ENV["GH_BASIC_SECRET_ID"],code: params[:code]}, 
    #   {'Accept' => 'application/json'}

    # body = JSON.parse(resp.body)
    # session[:token] = body["access_token"]

    # user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    # username = JSON.parse(user_resp.body)
    # session[:username] = username['login']

    # redirect_to root_path
 

    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to '/'
    end
end

