
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req['client_id'] = ENV['GITHUB_CLIENT_ID']
      req['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req['code'] = (params[:code])
      req['Accept'] = 'application/json'
    end

    hash = JSON.parse(resp.body)
    session[:token] = hash["access_token"]

    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    user_body = JSON.parse(user_resp.body)
    session[:username] = user_body["login"]

    redirect_to '/'
  end
end