class SessionsController < ApplicationController
  # Endless loop here if you do not skip this action
  skip_before_action :authenticate_user, only: :create

  def create
    # Setting this variable 'resp' to use faraday to do part 2 of the Web App Flow of authentication to recieve your token, it has the parameters of client_id (stored with ENV), client_secret (stored with ENV), and code which is returned with the authorize portion of the flow. For a cleaner look we pass in the accpet header of json.
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    # Parse the returned hash into JSON
    token_hash = JSON.parse(resp.body)
    # set the session[:token] with the access token sent from the parsed data
    session[:token] = token_hash["access_token"]

    # Setting the 'user_resp' variable to use faraday to retrieve the session[:username]. Faraday just needs the correct path and then no parameters but we do need to authorize the user by using the below syntax and the session[:token] we just set up above and again the accept header.
    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # Parse the returned hash into JSON
    user = JSON.parse(user_resp.body)
    # set the session[:username] with the login sent from the parsed data
    session[:username] = user["login"]

    # redirect back to the root
    redirect_to '/'
  end
end