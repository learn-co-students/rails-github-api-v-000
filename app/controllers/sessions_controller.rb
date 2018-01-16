class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    redirect_uri ="http://159.203.91.59:30003/auth"
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = "application/json"
      req.body = { client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET'], code: params[:code]}
    end


    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end

end
