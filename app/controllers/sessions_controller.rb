class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    #binding.pry
    #resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
         client_id = ENV['GITHUB_CLIENT_ID']
         client_secret = ENV['GITHUB_CLIENT_SECRET']
         code = params[:code]
        req.body = { 'client_id': nil, 'client_secret': nil, 'code': code }
        req.headers['Accept'] = 'application/json'

      end

      body = JSON.parse(response.body)
      session[:token] = body["access_token"]
      redirect_to root_path
    end
end
