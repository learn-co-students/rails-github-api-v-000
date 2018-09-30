class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |request|
      request.body = {
        'client_id': ENV['GITHUB_CLIENT_ID'],
        'client_secret': ENV['GITHUB_CLIENT_SECRET'],
        'code': params[:code] # code is found in the redirect URL http://localhost:3000/auth
      }
      request.headers['Accept'] = 'application/json'
    end

    body_hash = JSON.parse(response.body)
    session[:token] = body_hash['access_token']
    redirect_to root_path
  end
end
# get '/auth' => sessions#create
# We're sending my Rails app user to GitHub to authenticate w/ GitHub.
# Once the user logs into GitHub with valid credentials & grants my Rails app permission
# to access the user's GitHub login info (so my Rails app can do stuff on behalf of the user on GitHub),
# the user is sent back to my Rails app via the redirect URL, which contains a code from GitHub.
# My app takes this code and with it, makes a POST request to GitHub
# in order to get back the GitHub access token

# sessions#create receives GitHub's 'code' parameter
# which is found in the redirect authorization callback URL (http://localhost:3000/auth)
# and accessed as params[:code]
# It uses this code in conjunction with my GitHub app's Client ID and Client Secret
# (accessed as ENV['GITHUB_CLIENT_ID'] and ENV['GITHUB_CLIENT_SECRET'])
# to send a POST request to GitHub. The base URL = `https://github.com/login/oauth/access_token`.
# If the credentials are correct, GitHub sends a response that includes headers and a body.
# Within the body is an access token unique to this specific request.
# As is the case whenever data is sent from an API or web server,
# the response body is sent in the form of a string.
# To get data from this string, we must first parse the response body into a Ruby hash
# (and I store this hash in the body_hash variable)
# body_hash has a key of "access_token" pointing to the user's string GitHub access token
# So the user's GitHub access token can be accessed as body_hash['access_token']
# Store the user's GitHub access token in the session hash:
# session[:token] = body_hash['access_token']
# This indicates that the user is now logged-into GitHub, i.e., authenticated with GitHub
