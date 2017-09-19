class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create
  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |request|
      request.headers['Accept'] = 'application/json'
      request.body = {"code": params['code'], "client_id": ENV['GITHUB_CLIENT'], 'client_secret': ENV['GITHUB_SECRET']  }
    end
    body = JSON.parse(response.body)
    session[:token] = body['access_token']
    user = Faraday.get("https://api.github.com/user") do |request|
      request.headers = {Authorization: "token #{session[:token]}"}
    end

    session[:username] = JSON.parse(user.body)['login']
    redirect_to '/'
  end


end
