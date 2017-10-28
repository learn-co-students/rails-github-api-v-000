class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token",
      {client_id: ENV["GITHUB_CLIENT"],
        client_secret: ENV["GITHUB_SECRET"],
        code: params[:code]},
      {'Accept' => 'application/json'}

    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    u_response = Faraday.get "https://api.github.com/user", {},
    {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    u_json = JSON.parse(u_response.body)
    session[:username] = u_json["login"]
    redirect_to '/'
  end
end
