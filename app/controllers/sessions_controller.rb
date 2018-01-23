class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", { client_id:  ENV['GITHUB_CLIENT_ID'],
       client_secret:  ENV['GITHUB_CLIENT_SECRET'],
       code:  params[:code] },
      { 'Accept' => 'application/json'}

    body = JSON.parse(resp.body)

    #binding.pry
    session[:token] = body["access_token"]

    resp = Faraday.get "https://api.github.com/user", {},
      { 'Accept' => 'application/json', 'Authorization' => "token #{session[:token]}"}


    body = JSON.parse(resp.body)

    session[:username] = body["login"]

    redirect_to root_path
  end
end

