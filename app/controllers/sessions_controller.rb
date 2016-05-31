class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = 'CLIENT_ID'
      req.params['client_secret'] = 'CLIENT_SECRET'
      req.params['redirect_uri'] = 'http://localhost:3000/auth'
      req.params['code'] = params[:code]
    end
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']
    redirect_to root_path
  end
end
