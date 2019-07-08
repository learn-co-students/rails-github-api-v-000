class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      # binding.pry
      req.body = { 'client_id': ENV['GITHUB_CLIENT'], 'client_secret': ENV['GITHUB_SECRET'], 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
