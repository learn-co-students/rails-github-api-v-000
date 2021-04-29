class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
  req.body = { 'client_id': "232b40885fd61b5cc4b4", 'client_secret': "dbf3db7600da97b65efd7ae50d3350ed17d37068", 'code': params[:code] }
  req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    session[:token] = body['access_token']
    redirect_to '/'
  end




end
