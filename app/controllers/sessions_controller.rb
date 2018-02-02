class SessionsController < ApplicationController
	skip_before_action :authenticate_user

  def create
  	resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  		req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
  		req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
  		req.params['code'] = params[:code]
  	end
    if resp.body.include? 'access_token='
      session[:token] = resp.body.split('&')[0].gsub('access_token=','')
    else
      binding.pry
    end
  	redirect_to root_path
  end
end