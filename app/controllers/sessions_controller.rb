class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
  resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
    req.body = {'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': "#{params[:code]}"}
    req.headers = { Accept: 'application/json' }
  end

  token = JSON.parse(resp.body)['access_token']
  session[:token] = token

  user_response = Faraday.get "https://api.github.com/user" do |req|
       req.headers['Authorization'] = "token #{session[:token]}"
       req.headers['Accept'] = 'application/json'
     end

     user_json = JSON.parse(user_response.body)
     session[:user] = user_json["login"]
     redirect_to root_path

end


end
