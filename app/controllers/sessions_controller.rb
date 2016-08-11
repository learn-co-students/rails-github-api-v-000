class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # session.destroy
    # raise session.inspect

    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req["Accept"] = "application/json"
      req.params['code'] = params[:code]
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['grant_type'] = "authorization_code"
    end

    body = JSON.parse(response.body)
    session[:token] = body["access_token"]

    user_response = Faraday.get "https://api.github.com/user" do |req|
      req["Authorization"] = "token #{session[:token]}"
      req["Accept"] = "application/json"
    end
    user_body = JSON.parse(user_response.body)
    session[:username] = user_body['login']
    redirect_to root_path
  end

end
