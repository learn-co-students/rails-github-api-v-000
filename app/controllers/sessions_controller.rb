class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    binding.pry
    resp = Faraday.get("https://github.com/login/oauth/access_token", :headers => {'Accept'=>'application/json'}) do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      # req.params['grant_type'] = 'authorization_code'
      req.params['code'] = params[:code]
      req.params['redirect_uri'] = "http://localhost:3000/auth"
    end
    binding.pry
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    binding.pry
    redirect_to root_path
  end
end
