class SessionsController < ApplicationController
	skip_before_action :authenticate_user, only: :create

  def create
  	response = Faraday.post "https://github.com/login/oauth/access_token",{client_id:"5a506ebcd5c8369b89f9", client_secret:"10f1b6a9c23ff3808d2d7d3938d12d83c5ec29f8",code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end

end
