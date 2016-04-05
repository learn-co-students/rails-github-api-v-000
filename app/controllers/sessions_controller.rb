class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", 
    {client_id: ENV["ADQ4FIJYW3NNQW12EWUJGZJYRNJOYUSS3L3TWVVQHJ2JX01D"], 
      client_secret: ENV["33NVLHOV52YUO1OM4OA2MICF3ILATL231JR0MB5TTXNK5ZUX"],
      code: params[:code]},
       {'Accept' => 'application/json'}
    body = JSON.parse(response.body)

    session[:token] = body["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {},
     {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    
    redirect_to root_path
  end
end