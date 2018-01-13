class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    redirect_uri ="http://localhost:3000/auth"
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = "application/json"
      req.body = { client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET'], code: params[:code]}
    end


    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end

end

#
# Faraday.post("https://url/to/api") do |req|
#   req.params['my_param'] = my_value
# end
# You can do this:
# 
# Faraday.post("https://url/to/api") do |req|
#   req.body = "{ "my_param": my_value }"
# end
