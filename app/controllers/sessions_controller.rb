class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token", {
        client_id: ENV['GITHUB_CLIENT_ID'],
        client_secret: ENV['GITHUB_CLIENT_SECRET'],
        code: params[:code]
      }, {'Accept': 'application/json'})
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    user_resp = Faraday.get("https://api.github.com/user", {}, {
      'Authorization': "token #{session[:token]}",
      'Accept': 'application/json'
    })
    user_body = JSON.parse(user_resp.body)
    session[:username] = user_body['login']

    redirect_to root_path
  end
end
