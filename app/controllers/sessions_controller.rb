class SessionsController < ApplicationController
skip_before_action :authenticate_user, only: :create

  def create
    #receive code from github, make sure state matches to prevent 3rd party attempts
    #send faraday request with code
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params["client_id"] = ENV["client_id"]
      req.params["client_secret"] = ENV["client_secret"]
      req.params["code"] = params["code"]
      req.headers["Accept"] = "application/json"
    end
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