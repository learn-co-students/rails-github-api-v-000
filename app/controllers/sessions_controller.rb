class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = {'client_id': 'd9f034c64d27701a746f',
      'client_secret': 'b928e20750de6d04ae93ae9b69a77e8d5f793547',
      'code': '20'}
      #binding.pry
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']
    redirect_to root_path
  end

end
