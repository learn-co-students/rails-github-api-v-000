class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  def create
    # binding.pry
    # f = Faraday.new(url: 'https://github.com/login/oauth/authorize/access_token' )
    @resp =  Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_KEY"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
     response = JSON.parse(@resp.body)
     session[:token] = response['access_token']
     user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
     user_json = JSON.parse(user_response.body)
    #  binding.pry
     session[:user] = user_json['login']
     redirect_to root_path
  end
end
