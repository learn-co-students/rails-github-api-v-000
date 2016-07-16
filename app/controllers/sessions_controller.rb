class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    response = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] =ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] =ENV['GITHUB_CLIENT_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'

    end

    token = JSON.parse(response.body)["access_token"]
    session[:token] = token
    redirect_to root_path
  end
end
