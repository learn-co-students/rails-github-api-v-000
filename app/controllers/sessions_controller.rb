class SessionsController < ApplicationController
  # skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      # req.params['client_id'] = ENV['CLIENT_ID']
      # req.params['client_secret'] = ENV['CLIENT_SECRET']
      # req.params['code'] = params[:code]
      req.body = {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"],code: params[:code]}
      req.headers = {'Accept' => 'application/json'}
    end
binding.pry
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    # response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}

    redirect_to root_path
  end
end
