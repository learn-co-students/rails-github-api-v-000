class SessionsController < ApplicationController
  def new
    @key = ENV['GITHUB_CLIENT']
  end

  def create
    body_hash = {
      client_id: ENV['GITHUB_CLIENT'],
      client_secret: ENV['GITHUB_SECRET'],
      code: params['code']
    }
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.body = JSON.generate(body_hash)

      req.headers['Accept'] = 'application/json'
    end
    @token = JSON.parse(resp.body)['access_token']
    session['token'] = @token
    redirect_to root_path
  end

end
