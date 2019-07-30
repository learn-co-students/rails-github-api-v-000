class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT'], 'client_secret': ENV['GITHUB_SECRET'], 'code': params['code']  }
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)

  #  resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
  #  req.params['client_id'] = ENV['GITHUB_CLIENT']
  #  req.params['client_secret'] = ENV['GITHUB_SECRET']
  #  req.params['grant_type'] = 'authorization_code'
  #  req.params['redirect_uri'] = "http://localhost:3000/auth"
  #  req.params['code'] = params[:code]
  #end
  session[:token] = body["access_token"]
  redirect_to root_path
end

end

#n sessions_controller.rb, write a create method. This method should receive
#GitHub's code parameter and should use it in conjunction with your Client ID
#and Client Secret to send a POST request to GitHub. The base URL this time
#will be https://github.com/login/oauth/access_token.
