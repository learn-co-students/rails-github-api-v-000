class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = 'a4d3cdd8d8ff49fa54c7'
      req.params['client_secret'] = 'c7e0bf60f7bd3eb4d351078aaf61fffb64c26d24'
      # req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://159.203.117.55:3098/auth"
      req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
