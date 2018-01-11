class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token",
    {
      client_id: ENV["GITHUB_CLIENT"],
      client_secret: ENV["GITHUB_SECRET"],
      code: params[:code]
      }, {
        'Accept' => 'application/json'
      }

    session[:token] = JSON.parse(response.body)["access_token"]

    resp = Faraday.get "https://api.github.com/user",
    {}, {
      'Authorization' => "token #{session[:token]}",
       'Accept' => 'application/json'
     }

    session[:username] = JSON.parse(resp.body)["login"]

    redirect_to '/'
  end
end
