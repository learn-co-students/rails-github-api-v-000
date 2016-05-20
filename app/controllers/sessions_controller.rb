class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token",
      {
        client_id: ENV["GITHUB_CLIENT"],
        client_secret: ENV["GITHUB_SECRET"],
        code: params[:code]
      },
        {'Accept' => 'application/json'}

    user_session = JSON.parse(response.body)
    session[:token] = user_session["access_token"]

    redirect_to '/'
  end
end
