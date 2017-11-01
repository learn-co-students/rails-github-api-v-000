require 'pry'
class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
          req.headers['Accept'] = 'application/json'
          req.body = {
            'client_id': ENV['CLIENT_ID'],
            'client_secret': ENV['CLIENT_SECRET'],
            'code': params[:code]
          }
        end

    body = JSON.parse(resp.body)

    session[:token] = body['access_token']

    user_details_body = Faraday.get('https://api.github.com/user') do |req|
       req.headers['Authorization'] = "token #{session[:token]}"
     end

    user_details = JSON.parse(user_details_body.body)
    session[:username] = user_details['login']
    redirect_to root_path
  end
end
