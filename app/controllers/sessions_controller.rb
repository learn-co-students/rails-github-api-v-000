class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create #comes from '/auth'
      response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
        req.params['client_id'] = ENV["client_id"]
        req.params['client_secret'] = ENV["client_secret"]
        req.params["code"] = params["code"]
      end 
      hash = JSON.parse(response.body)
      session[:token] = hash["access_token"]
      redirect_to root_path
  end
end


# Parameters
# Name	Type	Description
# client_id	string	Required. The client ID you received from GitHub when you registered.
# client_secret	string	Required. The client secret you received from GitHub when you registered.
# code	string	Required. The code you received as a response to Step 1.
# redirect_uri	string	The URL in your application where users will be sent after authorization. See details below about redirect urls.
# state	string	The unguessable random string you optionally provided in Step 1.