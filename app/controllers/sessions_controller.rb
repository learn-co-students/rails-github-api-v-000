class SessionsController < ApplicationController
	skip_before_action :authenticate_user, only: [:create]
  
  def create
  	auth = Faraday.post("https://github.com/login/oauth/access_token") do |request|
  		request.body = {"client_id"=> ENV["GITHUB_CLIENT"], "client_secret"=> ENV["GITHUB_SECRET"], "code"=>"#{params[:code]}"}
      request.headers = { Accept: 'application/json' }
  	end

  	token = JSON.parse(auth.body)['access_token']
  	session[:token] = token
    
    user_response = Faraday.get('https://api.github.com/user') do |req|
          req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    end

    session['login'] = JSON.parse(user_response.body)['login']
  	redirect_to root_path
  end


end