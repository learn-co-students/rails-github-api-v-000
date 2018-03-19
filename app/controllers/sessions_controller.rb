class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {}
      req.body['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.body['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.body['code'] = params[:code]
      req.headers["Accept"] = "application/json"
      #binding.pry
    end
    #binding.pry
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end

  def destroy
    session[:token] = nil
    redirect_to root_path
  end
end
