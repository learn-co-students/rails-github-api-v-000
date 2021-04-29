class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      # req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET']}
      # req.headers['Accept'] = 'application/json'
      req.body = {"client_id"=>"d0b6c42deaddc9b6ff83", "client_secret"=>"5e0dea545cf3de3021424aec98ad3ecd622422b4", "code"=>"20"}
      req.headers = {
        'Accept'=>'application/json'
      }
    end
    body = JSON.parse(response.body)
    session[:token] = body['access_token']
    redirect_to root_path
  end
end
