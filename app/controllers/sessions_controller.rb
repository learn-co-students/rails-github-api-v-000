class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user_response = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end



  def destroy
    session[:token] = nil
    session[:username] = nil
    redirect_to root_path
  end

end
