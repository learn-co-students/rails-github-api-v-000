class SessionsController < ApplicationController
  def create
    response = Faraday.post "https://github.com/login/oauth/access_token",
    { client_id: 'f1a6907500f611b0f466',
      client_secret: '543bfac37a0c69a9bedd740d494371ee56e82205',
      code: params[:code]}, {'Accept' => 'application/json'}
      access_hash = JSON.parse(response.body)
      session[:token] = access_hash["access_token"]

      user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      user_json = JSON.parse(user_response.body)
      session[:username] = user_json["login"]

      redirect_to '/'
  end
end
