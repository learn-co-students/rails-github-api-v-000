class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    conn = Faraday.new(url: 'https://github.com/login/oauth/access_token')
    resp = conn.post do |req|
      req.headers['Accept'] = 'application/json'
      req.body = { client_id: ENV['GITHUB_CLIENT_ID'],
                   client_secret: ENV['GITHUB_SECRET'],
                   code: params[:code] }
    end
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    conn2 = Faraday.new(url: 'https://api.github.com/user')
    resp2 = conn2.get do |req|
      req.headers = { Accept: 'application/json',
                      Authorization: "token #{session[:token]}" }
    end
    user = JSON.parse(resp2.body)
    session[:username] = user['login']
    redirect_to root_path
  end
end
