require 'pry'

class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    resp = Faraday.post "https://api.github.com/login/oauth/access_token", {client_id: 'b9d48748698cca894c5c', client_secret: '3b0e5e41de42246b80d882c80d31133b3ce865ed', code: params[:code]}, {'Accept' => 'application/json'}

    binding.pry

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to '/'

  end

end