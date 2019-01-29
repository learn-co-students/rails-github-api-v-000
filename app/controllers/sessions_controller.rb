class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    # req.headers['Accept'] ='application/json'
    # req.params['client_id'] = ENV['CLIENT_ID']
    # req.params['client_secret'] = ENV['CLIENT_SECRET']
    # req.params['code'] = params[:code]
    # end
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.headers['Accept'] = 'application/json'
      req.body = { 'client_id':  ENV['CLIENT_ID'], 'client_secret': ENV['CLIENT_SECRET'], 'code': params[:code] }
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path

  end
end
