class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {
        "client_id" => ENV['GITHUB_CLIENT'],
        "client_secret" => ENV['GITHUB_SECRET'],
        "code" => params['code']
      }
      req.headers['Accept'] = 'application/json'
    end
    session[:token] = JSON.parse(resp.body)["access_token"]
    session[:username] = JSON.parse(resp.body)["login"]
    
    redirect_to root_path

  end
end
