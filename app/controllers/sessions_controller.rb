class SessionsController < ApplicationController
skip_before_action :authenticate_user, only: :create

  def create
    code = params[:code]
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = 'd36f553d228db3170acc' #ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = '204fa9c020c4a261ebba9c4346ff4049079eb9c0' #ENV['GITHUB_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = code
      req.params['scope'] = 'user repo'
      req.params['access_token'] = 'token'
    end

    body = JSON.parse(resp.body)
    puts "BODY #{body.inspect}"

    session[:token] = body["access_token"]

    # Move to own method
    response = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = 'token ' + session[:token]
    end

    body = JSON.parse(response.body)
    session[:username] = body["login"]
    session[:id] = body["id"]
    session[:name] = body["name"]
    # end Move to own method

    # session[:username]=
    redirect_to root_path
  end

  def logout
    session.clear
    redirect_to root_path
  end
end
