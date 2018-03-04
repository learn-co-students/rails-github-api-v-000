class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    # post request to GitHub with user's code
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_SECRET'], code: params[:code]}, {'Accept' => 'application/json'}

    body = JSON.parse(resp.body)
    # set the token
    session[:token] = body["access_token"]

    # log in to get user info
    user = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}"}

    user_info = JSON.parse(user.body)
    # store the username
    session[:username] = user_info["login"]

    redirect_to root_path
  end
end
