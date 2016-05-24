require 'pry'
class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
       req.headers = {'Accept' => 'application/json'}
       req.body = {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: params[:code]}
     end
  #  response = Faraday.post "https://github.com/login/oauth/access_token", {
  #    client_id: ENV["CLIENT_ID"],
  #    client_secret: ENV["CLIENT_SECRET"],
  #    code: params[:code]
  #    },
  #    {'Accept' => 'application/json'}

    response_hash = JSON.parse(response.body)
    session[:token] = response_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
binding.pry
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    redirect_to root_path
  end
end
