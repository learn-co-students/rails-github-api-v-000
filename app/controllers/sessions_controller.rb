class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    if (
      !session[:github_state] ||
      !params[:state] ||
      session[:github_state] != params[:state]
    )
      redirect_to root_path and return
    end

    resp =  Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['code'] = params[:code]

      req.headers['Accept'] = 'application/json'
    end
    
    if resp.success?
      access_token = JSON.parse(resp.body)['access_token']
      session[:github_token] = access_token if access_token
    end

    redirect_to root_path
  end
end