class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

    def create
        resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
        body = JSON.parse(resp.body)
        session[:token] = body["access_token"]

        user_info = Faraday.get "https://api.github.com/user",  {}, {'Authorization': "token #{session[:token]}", 'Accept' => 'application/json'}
        session[:username] = JSON.parse(user_info.body)

        # #WORKED FINE LIVE THREW ERROR WITH TESTS
        # resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
        #   req.params['client_id'] = ENV['GITHUB_CLIENT']
        #   req.params['client_secret'] = ENV['GITHUB_SECRET']
        #   req.params['code'] = params[:code]
        #   req.headers['Accept'] = "application/json"
        # end
        # body = JSON.parse(resp.body)
        # session[:token] = body["access_token"]

        # user_info = Faraday.get "https://api.github.com/user" do |req|
        #     req.params['access_token'] = session[:token]
        # end
        # user_body = JSON.parse(user_info.body)
        # session[:username] = user_body['login']
        
        redirect_to root_path
    end




end