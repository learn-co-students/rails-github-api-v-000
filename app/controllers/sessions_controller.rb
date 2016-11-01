class SessionsController < ApplicationController
	skip_before_action :authenticate_user
  
  def create
  	redirect_uri = 'http://localhost:3000/auth'
  	response = Faraday.get("https://github.com/login/oauth/authorize") do |request|
  		request.headers = { Authorization: ENV['GITHUB_CLIENT'] }
  		request.params['redirect_uri'] = redirect_uri
  	end

  	code = params['code']
  	auth = Faraday.post("https://github.com/login/oauth/access_token") do |request|
  		request.params['client_id'] = ENV['GITHUB_CLIENT']
  		request.params['client_secret'] = ENV['GITHUB_SECRET']
  		request.params['code'] = code
  		request.params['redirect_uri'] = redirect_uri
      request.headers = { accept: 'application/json' }
  	end

  	token = JSON.parse(auth.body)['access_token']
  	session[:token] = token
    
    user_response = Faraday.get('https://api.github.com/user') do |req|
          req.params['access_token'] = session[:token]
    end

    session['login'] = JSON.parse(user_response.body)['login']
  	redirect_to root_path
  end


end