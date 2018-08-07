class SessionsController < ApplicationController

  skip_before_action :authenticate_user

  def create
    resp = Faraday.get('https://github.com/login/oauth/access_token',
      {
        :client_id => ENV['CLIENT_ID'], 
        :client_secret => ENV['CLIENT_SECRET'],
        :code => params[:code]
      },
      'Accept' => 'application/json')

    session[:token] = JSON.parse(resp.body)["access_token"]

    user_response = Faraday.get("https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'})
    
    session[:username] = JSON.parse(user_response.body)["login"]

    redirect_to root_path
  end

end