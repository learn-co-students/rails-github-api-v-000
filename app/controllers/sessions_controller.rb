class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers = {"Accept" => 'application/json'}
      req.body = {
        'client_id' => ENV['GITHUB_CLIENT_ID'],
        'client_secret' => ENV['GITHUB_CLIENT_SECRET'],
       'redirect_uri' => "http://localhost:3000/auth",
        'code' => params[:code]
      }
    end

    access_hash = JSON.parse(resp.body)
    session[:token] = access_hash["access_token"]

    user_info = Faraday.get('https://api.github.com/user') do |req|

      req.headers ={
        'Authorization' => "token #{session[:token]}",
        'Accept' => 'application/json'
      }
    end

    user_hash = JSON.parse(user_info.body)
    session[:username] = user_hash["login"]

    redirect_to root_path
  end
end
