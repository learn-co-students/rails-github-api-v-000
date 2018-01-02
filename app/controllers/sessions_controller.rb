class SessionsController < ApplicationController
  skip_before_action :authenticate_user

def create

  resp_post = Faraday.post('https://github.com/login/oauth/access_token') do |req|
        req.headers['Accept'] = 'application/json'
        req.params['client_id'] = ENV['CLIENT_ID']
        req.params['client_secret'] = ENV['CLIENT_SECRET']
        req.params['code'] = params[:code]
      end



  body_post = JSON.parse(resp_post.body)
  session[:token] = body_post["access_token"]

  resp_get = Faraday.get("https://api.github.com/user") do |req|
    req.headers['Authorization'] = "token #{session[:token]}"
  end

  body_get = JSON.parse(resp_get.body)

  session[:username] = body_get["login"]

  redirect_to '/'
end
end
