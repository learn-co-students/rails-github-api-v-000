class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # receive GitHub's code parameter and should use it in conjunction with your Client ID and Client Secret to send a POST request to GitHub
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']

    code = params["code"]
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      # accept JSON as a response
      req.headers['Accept'] = 'application/json'
    end

    #  parses the response body into a Ruby hash and stores this hash as the body variable
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
