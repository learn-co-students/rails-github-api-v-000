class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code]}, {"Accept" => 'application/json'}  
    result = JSON.parse(resp.body)
    session[:token] = result["access_token"]

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
    end
    user_info = JSON.parse(user_resp.body)
    session[:username] = user_info["login"]
    redirect_to root_path
  end
end
