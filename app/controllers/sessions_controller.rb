class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    def create
      resp = Faraday.post 'https://github.com/login/oauth/access_token', {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
      body = JSON.parse(resp.body)
  	  access_token = body["access_token"]
      session[:token] = access_token

      resp = Faraday.get 'https://api.github.com/user', {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      @user_info = JSON.parse(resp.body)
   	  session[:username] = @user_info["login"]
      redirect_to root_path
     end
  end
end
