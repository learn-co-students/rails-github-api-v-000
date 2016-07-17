class SessionsController < ApplicationController
  skip_before_action :authenticate_user


  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body= {
        "client_id"=> ENV['GITHUB_CLIENT'],
        "client_secret"=> ENV['GITHUB_SECRET'], "code"=> "#{params[:code]}"
      }.to_json
      #req.headers['Accept']= "application/json"
    end

    binding.pry
    token = JSON.parse(response.body)["access_token"]
    session[:token] = token
    @username = current_user
    binding.pry
    redirect_to root_path
  end
end
