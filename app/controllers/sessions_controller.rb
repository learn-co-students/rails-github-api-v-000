class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    json = JSON.parse(resp.body)
    session[:token] = json["access_token"]

    session[:user]= get_user
    redirect_to root_path
  end

  private
    def get_user
      resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      json = JSON.parse(resp.body)
      json["login"]
    end
end
