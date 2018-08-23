class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      # req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      # req.params['client_secret'] = ENV['GITHUB_SECRET']
      # req.params['code'] = sessions[:code]
      binding.pry
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_SECRET'], 'code': session[:code] }
      req.headers['Accept'] = 'application/json'
    end
    binding.pry
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
