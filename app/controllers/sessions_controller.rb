class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  

    # skip_before_action :authenticate_user, only: :create
    
    def create
      # binding.pry
        response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
          req.headers['Accept'] = 'application/json'

          req.body = {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"],code: params["code"]}
          # req.body = {"client_id"=>"db262a0bdcb734f7e655", "client_secret"=>"73a26bd44c3b5da291f3af26346030d5312c00ec", "code"=>"20"}

          end
          body = JSON.parse(response.body)
          session[:token] = body["access_token"]
        redirect_to root_path
      end



end
