class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    get = Faraday.new(url: 'https://github.com/login/oauth/access_token')
    resp = get.post do |req|
      req.headers['Accept'] = 'application/json'
      req.body = { client_id: ENV['GITHUB_CLIENT'],
                   client_secret: ENV['GITHUB_SECRET'],
                   code: params[:code] }
    end
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    get2 = Faraday.new(url: 'https://api.github.com/user')
    resp2 = get2.get do |req|
      req.headers = { Accept: 'application/json',
                      Authorization: "token #{session[:token]}" }
    end
    userData = JSON.parse(resp2.body)
    session[:username] = userData['login']
    redirect_to root_path
  end
end
