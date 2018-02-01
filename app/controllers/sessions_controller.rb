class SessionsController < ApplicationController
	skip_before_action :authenticate_user

  def create
  	resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  		req.params['client_id'] = ENV['client_id']
  		req.params['client_secret'] = ENV['client_secret']
  		req.params['code'] = params[:code]
  	end
  	session[:token] = resp.body.split('&')[0].gsub('access_token=','')
  	redirect_to root_path
  end
end