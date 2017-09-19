class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['code'] = params[:code]
    end
    session[:token] = response.body.split("=")[1]
    user_response = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
    session[:user] = JSON.parse(user_response.body)
    redirect_to root_path
  end
end
