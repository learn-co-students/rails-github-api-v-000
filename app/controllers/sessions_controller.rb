class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV["GITHUB_CLIENT_ID"]
      req.params['client_secret']= ENV["GITHUB_SECRET"]
      req.params['code']= params[:code]
      req.headers['Accept'] = 'application/json'
    end

    session[:token] = JSON.parse(resp.body)["access_token"]

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Accept"] = "application/json"
      req.headers["Authorization"] = "token #{session[:token]}"

    end

    session[:username] = JSON.parse(user_resp.body)["login"]

    redirect_to '/'
  end
end
