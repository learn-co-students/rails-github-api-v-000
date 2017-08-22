class SessionsController < ApplicationController
	skip_before_action :authenticate_user
  def create
  	response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
  	response_data = JSON.parse(response.body)
  	session[:token] = response_data["access_token"]

  	user_info_request = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_info_data = JSON.parse(user_info_request.body)
    session[:username] = user_info_data["login"]
    redirect_to '/'
  end


end

# Github API Notes
# ________________
# client_id	string	Required. The client ID you received from GitHub for your GitHub App.
# client_secret	string	Required. The client secret you received from GitHub for your GitHub App.
# code	string	Required. The code you received as a response to Step 1.
# redirect_uri	string	The URL in your application where users are sent after authorization.
# state	string	The unguessable random string you provided in Step 1.
