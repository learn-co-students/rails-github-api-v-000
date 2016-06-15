class SessionsController < ApplicationController

   skip_before_action :authenticate_user, only: :create


  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)

    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to '/'

  end



=begin
First try!
  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.body = "{ 
      'client_id': #{ENV['GITHUB_CLIENT_ID']}, 
      'client_secret': #{ENV['GITHUB_SECRET']},
      'code': #{params[:code]} 
        }"
    end
    raise resp.inspect
 
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

   
    redirect_to "/"
  end
=end

=begin
#Chad's try!
  def create
    resp = Faraday.post do |req|
      req.url 'https://github.com/login/oauth/access_token'
      req.headers['Content-Type'] = 'application/json'
      req.body = "{
      'client_id': #{ENV['GITHUB_CLIENT_ID']}, 'client_secret': #{ENV['GITHUB_SECRET']}, 'code': #{params[:code]}
        }" 
    end

    raise resp.inspect

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to "/"
  end
=end
end