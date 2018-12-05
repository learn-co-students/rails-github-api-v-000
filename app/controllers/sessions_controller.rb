class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    #Setting the client ID and Secret variables
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    code = params['code']

    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {'client_id': client_id, 'client_secret': client_secret, 'code': code}
      #Telling Gihub we will accept JSON as a response
      req.headers['Accept'] = 'application/json'
    end

    #parsing the response body into a ruby hash and store hash as a body varaiable
    body = JSON.parse(response.body)
    session[:token] = body['access_token'] #Need this token whenever we send API requests, so best place to store this is in the session ie session[:token]
    redirect_to root_path #after parsing and storing the token as a session value redirect to the root path
  end
end
