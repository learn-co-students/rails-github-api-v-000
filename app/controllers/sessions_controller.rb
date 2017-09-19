class SessionsController < ApplicationController
  require 'json'

  skip_before_action :authenticate_user, only: [:create]

  def create
      resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
        req.body = {'client_id' => ENV['GITHUB_KEY'], 'client_secret' => ENV['GITHUB_SECRET'], 'code' => params['code']}.to_json
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
      end
      body = JSON.parse(resp.body)
      session[:token] = body['access_token']
      redirect_to root_url
  end
end
