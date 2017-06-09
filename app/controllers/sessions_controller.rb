class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create
  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |request|
      request.headers['Accept'] = 'application/json'
      request.body = [{"code": params['code']}, {"client_id": ENV['GITHUB_CLIENT']}, {'client_secret': ENV['GITHUB_SECRET']}].to_json


    end
    binding.pry
    body = JSON.parse(response.body)
    session[:token] = body['access_token']
    redirect_to 'http://localhost:3000'
  end


end
