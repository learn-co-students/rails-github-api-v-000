class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
  	#raise "hello"
  	# resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
	  #   req.params['client_id'] = 'f4f59837c58ce54bcb73'
	  #   req.params['client_secret'] = 'fba58bfab71f5f94210b9605d551999af37ed7de'
	  #   #req.params['grant_type'] = 'authorization_code'
	  #   #req.params['redirect_uri'] = "http://localhost:3000/auth"
	  #   req.params['code'] = params[:code]
	  # end
	  resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT'], client_secret: ENV['GITHUB_SECRET'],code: params[:code]}, {'Accept' => 'application/json'}
	  body = JSON.parse(resp.body)
	  #raise body
	  session[:token] = body["access_token"]


	  user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      user_json = JSON.parse(user_response.body)
      session[:username] = user_json["login"]

	  redirect_to root_path
  end
end