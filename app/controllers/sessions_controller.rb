class SessionsController < ApplicationController
    skip_before_action :authenticate_user

    def create
        resp = Faraday.post "https://github.com/login/oauth/access_token", 
            {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, 
            {'Accept' => 'application/json'}
        
        body = JSON.parse(resp.body)
        session[:token] = body["access_token"]

        getUser

        redirect_to root_path
    end

    private
    def getUser
        resp = Faraday.get("https://api.github.com/user") do |req|
            req.headers = {Accept: 'application/json', Authorization: "token "+session[:token]}
        end

        body = JSON.parse(resp.body)
        session[:username] = body['login']
    end
end