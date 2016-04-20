class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  
  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {
        client_id: ENV['GITHUB_CLIENT'],
        client_secret: ENV['GITHUB_SECRET'],
        code: params[:code]
      },
      {'Accept' => 'application/json'}
    
    resp_hash = JSON.parse(resp.body)
    session[:token] = resp_hash["access_token"]

    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    session[:username] = JSON.parse(user.body)['login']

    redirect_to root_path
  end
end