class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  def create
    # binding.pry
    resp = Faraday.post('https://github.com/login/oauth/authorize/access_token') do |options|
      options.params['client_id'] = ENV['GITHUB_KEY']
      options.params['client_secret'] = ENV['GITHUB_SECRET']
      options.params['redirect_uri'] = 'http://localhost:3000/auth/github'
      options.params['code'] = params[:code]
      options.headers['Accept'] = 'application/json'
    end
    binding.pry
    response = JSON.parse(resp.body)
  end
end
