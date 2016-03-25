require 'pry'
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params["client_id"] = ENV["GITHUB_CLIENT_ID"]
      req.params['client_secret'] = ENV["GITHUB_SECRET"]
      req.params['code'] = 20
      req.params['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user_resp = Faraday.get "https://api.github.com/user",
    {},
    {'Authorization' => "token #{session[:token]}",
      'Accept' => 'application/json'}

    user_json = JSON.parse(user_resp.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end

end