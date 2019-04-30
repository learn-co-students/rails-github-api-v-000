class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    
    session[:token] = sessions_params[:code]
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
     byebug
    redirect_to "/"
  end
  
  def sessions_params
    params.permit(:code, :username)
  end 
end
