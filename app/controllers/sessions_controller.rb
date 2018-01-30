class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    # resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
    #   req.body = {}
    #   req.body['client_id'] = ENV['GITHUB_CLIENT_ID']
    #   req.body['client_secret'] = ENV['GITHUB_SECRET']
    #   req.body['code'] = params[:code]
    #   req.headers = {'Accept' => 'application/json'}
    # end

    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT_ID'], client_secret:  ENV['GITHUB_SECRET'], code: params[:code]}, {'Accept' => 'application/json'}

    auth_hash = JSON.parse(resp.body)
    session[:token] = auth_hash["access_token"]
    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_value = JSON.parse(user_resp.body)
    session[:username] = user_value["login"]

    redirect_to '/'
  end
end
