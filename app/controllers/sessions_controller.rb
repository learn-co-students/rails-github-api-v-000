class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    #what i originally had / webmock doesn't like block
    # resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
    #   req.params['client_id'] = ENV['GITHUB_CLIENT']
    #   req.params['client_secret'] = ENV['GITHUB_SECRET']
    #   req.params['code'] = params[:code]
    #   req.headers['Accept'] = 'application/json'
    # end
     resp = Faraday.post 'https://github.com/login/oauth/access_token', {client_id: ENV['GITHUB_CLIENT'], client_secret: ENV['GITHUB_SECRET'], code: params[:code]}, {Accept: 'application/json'}

    session[:token] = JSON.parse(resp.body)["access_token"]

    user = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    session[:username] = JSON.parse(user.body)["login"]
    redirect_to '/'

  end

end
