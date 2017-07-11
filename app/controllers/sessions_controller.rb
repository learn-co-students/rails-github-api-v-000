require 'pry'

class SessionsController < ApplicationController
 skip_before_action :authenticate_user, only: :create

  def create
    #If the user accepts your request, GitHub redirects back to your site with a temporary code in a code parameter
    #Exchange this code for an access token: with the post request

    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    binding.pry
    session[:token] = access_hash["access_token"]

    #Use the access token to access the API. The access token allows you to make requests to the API on a behalf of a user.
    #You can pass the token in the query params as shown above, but a cleaner approach is to include it in the Authorization header. Authorization: token OAUTH-TOKEN

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    # binding.pry
    # @user = user_json["login"]
    session[:username] = user_json["login"]

    redirect_to '/'
  end
 end
