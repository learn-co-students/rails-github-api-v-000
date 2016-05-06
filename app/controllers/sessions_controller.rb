class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create  

  def create
byebug
    gh_id=ENV['GITHUB_ID']
    gh_secret=ENV['GITHUB_SECRET']
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.headers['Accept']='application/json'
      req.body = { 'client_id': gh_id,
                    'client_secret': gh_secret, 
                    'code': params[:code], 
                    }   
    end
byebug
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path

  end
end