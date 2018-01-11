class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      req.body = {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code]}
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    uresp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    body_json = JSON.parse(uresp.body)
    session[:username] = body_json["login"]
    redirect_to root_path
  end
end
