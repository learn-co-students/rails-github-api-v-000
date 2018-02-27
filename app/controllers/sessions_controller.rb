class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token',
      {
        client_id: ENV['GITHUB_CLIENT_ID'],
        client_secret: ENV['GITHUB_CLIENT_SECRET'],
        code: params[:code]
      },
      {
        Accept: "application/json",
        #Authorization: "token #{session[:token]}"
        })
    #binding.pry
  	body = JSON.parse(resp.body)
  	session[:token] = body['access_token']

    userResp = Faraday.get('https://api.github.com/user',
      {}, {Authorization: "token #{session[:token]}"}
      )
    userBody = JSON.parse(userResp.body)
    session[:username] = userBody['login']
  	redirect_to root_path
  end
end