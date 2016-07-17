class SessionsController < ApplicationController
  skip_before_action :authenticate_user


  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {
        'client_id'=> ENV['GITHUB_CLIENT'],
        'client_secret'=> ENV['GITHUB_SECRET'],
        'code'=> "#{params[:code]}"
      }
      req.headers = { 'Accept'=> 'application/json'}
    end


    token = JSON.parse(response.body)["access_token"]
    session[:token] = token
    @username = current_user
    binding.pry
    render "repositories/index"
  end
end
