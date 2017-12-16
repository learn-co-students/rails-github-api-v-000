class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create

    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = '35595bdf7017f9ad88ec'
      req.params['client_secret'] = '222765fb8902b7309a4d05628edb4f58d6c54c45'
      req.params['code'] = params[:code]
      #binding.pry
    end

    binding.pry

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
