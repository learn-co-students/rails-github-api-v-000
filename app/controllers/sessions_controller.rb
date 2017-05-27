class SessionsController < ApplicationController
    skip_before_action :authenticate_user

    def create
        resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
            req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
            req.params['client_secret'] = ENV['GITHUB_SECRET']
            req.params['grant_type'] = 'authorization_code'
            req.params['redirect_uri'] = "http://localhost:3000/auth"
            req.params['code'] = params[:code]
            req.params['scope'] = 'repo'
            req.headers = {Accept: 'application/json'}
        end
        
        body = JSON.parse(resp.body)
        session[:token] = body["access_token"]

        getUser

        redirect_to root_path
    end

    private
    def getUser
        resp = Faraday.get("https://api.github.com/user") do |req|
            req.params['access_token'] = session[:token]
            req.headers = {Accept: 'application/json'}
        end
        
        body = JSON.parse(resp.body)
        session[:username] = body['login']
    end
end