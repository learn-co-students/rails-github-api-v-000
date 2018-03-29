class SessionsController < ApplicationController
  skip_before_action :authenticate_user,  only: :create

  def create
    # state = "GOCVKFbt4httKVmlaBbBqfY32TE"
    
    client_id = ENV["GITHUB_CLIENT"]
    client_secret =  ENV["GITHUB_SECRET"]
    # auth_token = Faraday.post "https://github.com/login/oauth/access_token" do |req|
    auth_token = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret, code: params[:code]}.to_json, {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
      # req.headers['Accept'] = "application/json"
      # req['Content-Type'] = "application/json"
      # req.params = {
      #   'client_id': ENV['GITHUB_CLIENT_ID'],
      #   'client_secret': ENV['GITHUB_CLIENT_SECRET'],
      #   'code': params[:code],
      #   # 'state': params[:state]
      # }
      # end
    auth_response = JSON.parse(auth_token.body)
    session[:token] = auth_response["access_token"]    
    # resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_info = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}"}
    # , 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    # user_json = JSON.parse(user_info.body)
    session[:username] = JSON.parse(user_info.body)["login"]

    redirect_to "/"
  end
  
end
Failure/Error: visit '/auth?code=20' WebMock::NetConnectNotAllowedError: Real HTTP connections are disabled. Unregistered request