class SessionsController < ApplicationController
skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
      body = JSON.parse(response.body)
      if body["error"]
        @error_description = body["error_description"]
      end
      session[:token] = body["access_token"]

    #get username from api
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    body_json = JSON.parse(resp.body)
    session[:username] = body_json["login"]  
      
    redirect_to '/'
  end

  def logout
    session.clear
    redirect_to root_path
  end
end