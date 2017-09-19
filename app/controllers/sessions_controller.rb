class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  
    def create
      response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
        req.body = {client_id: ENV["GITHUB_CLIENT"], 
                    client_secret: ENV["GITHUB_SECRET"], 
                    code: params[:code]}
        req.headers["Accept"] = 'application/json'
      end
      body = JSON.parse(response.body)
      session[:token] = body["access_token"]
  
      user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      user_json = JSON.parse(user_response.body) 
      session[:username] = user_json["login"]
  
      redirect_to '/'
    end
end