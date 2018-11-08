class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['redirect_uri'] = "http://165.227.81.218:37734/auth"
      req.params['code'] = params[:code]
    end
    binding.pry
    session[:token] = resp["access_token"]
    redirect_to root_path
  end
end
