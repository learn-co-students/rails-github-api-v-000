class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    #this is where we make a request to github for a token to use. this token will be stored in session and then user will be logged_in
    #github oauth workflow documentation tells us to make a POST and to send the params via the response header/body. 
    #we also send an accept param stating we would like the response in json
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_SECRET']
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      req.headers['Accept'] = 'application/json'
    end
    # parse the response from a string to a hash so we can get the data out
    binding.pry
    body = JSON.parse(response.body)

    #log the user in with session
    session[:token] = body["access_token"]
    redirect_to root_path

    #user is redirected to home page and authenticate_user is called again, but since they are logged in, they wont be redirected to gihub again. rather the homepage will display

  end
end
