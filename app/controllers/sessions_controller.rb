class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create

    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET'], code: params[:code], redirect_uri: 'http://localhost:3000'}, {'Accept' => 'application/json'}
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
