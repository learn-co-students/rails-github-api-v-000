class SessionsController < ApplicationController
  skip_before_action :authenticate_user


  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      req.body = {
        "client_id"=> ENV['GITHUB_CLIENT_ID'],
        "client_secret"=> ENV['GITHUB_CLIENT_SECRET'],
        "code"=> "#{params[:code]}",
        "grant_type"=> "authorization_code",
        "redirect_uri"=> "http://localhost:3000/auth"
      }.to_json
    end


    binding.pry
    token = JSON.parse(response.body)["access_token"]
    session[:token] = token
    current_user
    redirect_to root_path
  end
end
