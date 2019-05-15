class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    code = params['code']
    
    resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      req.headers['Accept'] = 'application/json'
    end
    
    # Notice here, we are also including an 'Accept' header, as well. In this case, we are telling GitHub's server that we will accept JSON as a response.

    # If the credentials are correct, GitHub will send a response that includes headers and a body. Within the body is an access token unique to this specific request.

    body = JSON.parse(resp.body)
    session[:token] = body['access_token']
    
    redirect_to root_path
  end
  
end
