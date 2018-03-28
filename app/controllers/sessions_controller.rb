class SessionsController < ApplicationController
  skip_before_action :authenticate_user,  only: :create

  def create
    state = "GOCVKFbt4httKVmlaBbBqfY32TE"
    auth_token = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
    #   req.headers['Accept'] = "application/json"
    #   req['Content-Type'] = "application/json"
    #   req['User-Agent'] = 'Faraday v0.9.1']
    #   req.params = {
    #     'client_id': ENV['GITHUB_CLIENT_ID'],
    #     'client_secret': ENV['GITHUB_CLIENT_SECRET'],
    #     'code': params[:code],
    #     'state': params[:state]
    #   }
      # end
    auth_response = JSON.parse(auth_token.body)
    session[:token] = auth_response["access_token"]    
    

    user_info = Faraday.get "https://api.github.com/user",{},{'Authorization' => "token session[:token]", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_info.body)
    session[:username] = user_json["login"]

    redirect_to "/"
  end
  
end