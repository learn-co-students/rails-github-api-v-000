class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  def create
    # binding.pry
    # f = Faraday.new(url: 'https://github.com/login/oauth/authorize/access_token' )
    @resp = Faraday.post('https://github.com/login/oauth/authorize/access_token') do |options|
      options.params['client_id'] = ENV['GITHUB_KEY']
      options.params['client_secret'] = ENV['GITHUB_SECRET']
      options.params['redirect_uri'] = 'http://localhost:3000/auth'
      options.params['code'] = params[:code]
      options.headers['Accept'] = 'application/json'
      binding.pry
    end
    # response = JSON.parse(resp.body)
  end
end
