require 'pry'
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    data = {"client_id": ENV["GITHUB_CLIENT"], "client_secret": ENV["GITHUB_SECRET"], "code": params[:code]}

    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      # req.params["client_id"] = ENV['GITHUB_CLIENT_ID']
      # req.params["client_secret"] = ENV['GITHUB_SECRET']
      # req.params["code"] = params[:code]
      req.body = data
    end

    body_hash = JSON.parse(resp.body)
    session[:token] = body_hash["access_token"]

    results = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    user_hash = JSON.parse(results.body)
    session[:username] = user_hash["login"]
    redirect_to root_path
  end
end
