class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['code'] = params[:code]
      req.params['redirect_uri'] = "http://yangc5-v-000-150060.nitrousapp.com:3000/auth"
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path

  end
end