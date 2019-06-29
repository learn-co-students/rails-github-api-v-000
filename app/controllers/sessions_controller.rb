class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT'], 
        'client_secret': ENV['GITHUB_SECRET'], 
        'code': params[:code] }, 
      # req.headers['Accept'] = 'application/json'
      headers = {
        'Accept'=>'application/json',
        # 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        # 'Content-Type'=>'application/x-www-form-urlencoded',
        # 'User-Agent'=>'Faraday v0.15.4'
        }
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user_response = Faraday.get "https://api.github.com/user", 
    {}, 
    {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    
    redirect_to root_path
  end
end
