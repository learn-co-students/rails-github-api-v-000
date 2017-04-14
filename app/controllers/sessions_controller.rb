class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    url = 'https://github.com/login/oauth/access_token'
    resp = Faraday.post(url) do |req|
      req.headers['Accept'] = 'application/json'

      req.body = {
        'client_id':     ENV['GITHUB_CLIENT'],
        'client_secret': ENV['GITHUB_SECRET'],
        'code':          params['code']
      }
    end

    body = JSON.parse(resp.body)

    session[:token] = body['access_token']
    redirect_to root_path
  end
end
