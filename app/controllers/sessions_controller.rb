class SessionsController < ApplicationController
   skip_before_action :authenticate_user

  def create

  	token_request = Faraday.post("https://github.com/login/oauth/access_token") do |req|
  		req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
  		req.params['client_secret'] = ENV['GITHUB_SECRET']
  		req.params['code'] = params[:code]
  end
  session[:token] = token_request.body
  redirect_to root_path
end

# client_id	string	Required. The client ID you received from GitHub for your GitHub App.
# client_secret	string	Required. The client secret you received from GitHub for your GitHub App.
# code	string	Required. The code you received as a response to Step 1.


# def create
#   resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
#     req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
#     req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
#     req.params['grant_type'] = 'authorization_code'
#     req.params['redirect_uri'] = "http://localhost:3000/auth"
#     req.params['code'] = params[:code]
#   end
 
#   body = JSON.parse(resp.body)
#   session[:token] = body["access_token"]
#   redirect_to root_path
 end