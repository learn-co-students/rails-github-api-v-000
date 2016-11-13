class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    binding.pry
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      req.body = {
        client_id: ENV["GITHUB_CLIENT_ID"],
        client_secret: ENV["GITHUB_CLIENT_SECRET"],
        code: params[:code],
      }
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    binding.pry
    user = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_hash = JSON.parse(user.body)
    session[:username] = user_hash["login"]
    redirect_to root_path
  end
end
