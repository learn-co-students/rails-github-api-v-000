class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["eda70c6f0c3eb1bd5ec4"], client_secret: ENV["3c6856e786760a2715c4fa3b1a5f66b3d905c57b"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to '/'
  end
end
