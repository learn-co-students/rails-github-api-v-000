class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token",
      {client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET'],
      code: params[:code]}, {'Accept' => 'application/json'}
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    res = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    response = JSON.parse(res.body)
    session[:current_user] = response[:login]
    redirect_to root_path
  end
end
