class SessionsController < ApplicationController

  skip_before_action :authenticate_user#, only: :create
  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |request|
      request.headers['Accept'] = 'application/json'
      request.params['code'] = params['code']
      request.params['client_id'] = ENV['GITHUB_CLIENT']
      request.params['client_secret'] = ENV['GITHUB_SECRET']
    end
    binding.pry
    body = JSON.parse(response.body)
    session[:token] = body['access_token']
    redirect_to root_path


  end


end
