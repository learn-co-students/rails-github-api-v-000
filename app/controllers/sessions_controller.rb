class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req['client_id'] = ENV['GITHUB_CLIENT_ID']
      req['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req['code'] = (params[:code])
      req['Accept'] = 'application/json'
    end
    access = JSON.parse(resp.body)
    #binding.pry
    session[:token] = access["access_token"]

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req['Authorization'] = "token #{session[:token]}"
      req['Accept'] = 'application/json'
    end
    user_parse = JSON.parse(user_resp.body)
    session[:username] = user_parse["login"]

    redirect_to '/'
  end
end
