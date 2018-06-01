class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  # POST https://github.com/login/oauth/access_token
  #   ?client_id=
  #   &client_secret=
  #   &code=

  # The code below works but, won't pass the spec.
  # def create
  #   resp = Faraday.post("https://github.com/login/oauth/access_token", { client_id: ENV['GITHUB_CLIENT'], client_secret: ENV['GITHUB_SECRET'], code: params[:code]}, { 'Accept' => 'application/json' })

  #   body = JSON.parse(resp.body)
  #   session[:token] = body["access_token"]
  #   redirect_to root_path
  # end

  # This code passes the spec.


  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
                req.body = {"client_id": ENV['GITHUB_CLIENT'],
                "client_secret": ENV['GITHUB_SECRET'],
                "code": params[:code]}
                req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
