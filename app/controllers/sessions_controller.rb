class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  

    # skip_before_action :authenticate_user, only: :create
    
    def create
        response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
          
          req.body = {'GITHUB_CLIENT_ID': ENV["GITHUB_CLIENT_ID"], 'GITHUB_CLIENT_SECRET': ENV["GITHUB_CLIENT_SECRET"]}
            req.headers['Accept'] = 'application/json'
          
        end
       
        body = JSON.parse(respone.body)
        session[:token] = body["access_token"]
        redirect_to root_path
      end



end
