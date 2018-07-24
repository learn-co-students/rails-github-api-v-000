class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {
      client_id: ENV['GITHUB_CLIENT'],
      client_secret: ENV['GITHUB_SECRET'],
      code: params[:code] }
      req.headers = {'Accept' => 'application/json'}
    end

    token = JSON.parse(resp.body)
    session[:token] = token["access_token"]

    resp2 = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {
        "Authorization" => "token #{session[:token]}",
        'Accept' => 'application/json'}
    end


    resp2_hash = JSON.parse(resp2.body)
    session[:username] = resp2_hash['login']

    redirect_to root_path
  end
end
