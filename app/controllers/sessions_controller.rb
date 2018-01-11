class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post 'https://github.com/login/oauth/access_token', {
      client_id: ENV['GITHUB_CLIENT'],
      client_secret: ENV['GITHUB_SECRET'],
      code: params[:code]
    }, {
      Accept: 'application/json'
    }

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    session[:username] = body["login"]
    redirect_to root_path
  end

end
