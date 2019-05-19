class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

    def create
      resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
        req.body = { client_id: ENV['client_id'],
                      client_secret: ENV['client_secret'],
                      redirect_uri: "http://localhost:3000/auth",
                      code: params[:code]}
      end
      body = JSON.parse(resp.body)
      session[:token] = body["access_token"]
      redirect_to root_path
    end

end
