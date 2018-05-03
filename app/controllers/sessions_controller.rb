class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token', {client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET'], code: params['code']})
    
    session[:token] = params['access_token']
    redirect_to root_path
  end
end
