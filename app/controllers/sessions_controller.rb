class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['redirect_uri'] = 'http://localhost:3000/auth'
      req.params['code'] = params[:code]
    end
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    username = JSON.parse(user.body)
    session[:user] = username['login']
    redirect_to root_path
#    binding.pry
  end

end
