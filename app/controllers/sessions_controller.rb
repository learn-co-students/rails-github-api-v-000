class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    if params[:state] = ENV['STATE']
      resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
        req.headers['accept'] = 'application/json'
        req.params['state'] = ENV['STATE']
        req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
        req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
        req.params['code'] = params[:code]
      end

      body = JSON.parse(resp.body)
      session[:token] = body['access_token']
      redirect_to root_url
    end
  end
end
