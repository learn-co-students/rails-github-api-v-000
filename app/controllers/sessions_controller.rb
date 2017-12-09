class SessionsController < ApplicationController

	skip_before_action :authenticate_user

  def create

  	# resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  	# 	req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
  	# 	req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
  	# 	req.params['code'] = params[:code]
  	# end
  	
		resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
	          req.body = {
	          "client_id": ENV['GITHUB_CLIENT_ID'],
	          "client_secret": ENV['GITHUB_CLIENT_SECRET'], 
	          "code": params[:code]},
	          req.headers['Accept'] = 'application/json'
		end
		binding.pry	
		session[:token] = JSON.parse(resp.body)["access_token"]
	  # session[:token] = resp.body[/(?<=\=)(.*?)(?=&)/]
	  redirect_to root_path
  end

end
