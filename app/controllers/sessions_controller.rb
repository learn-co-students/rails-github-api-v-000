class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create  

  def create
byebug
    gh_id=ENV['GITHUB_CLIENT']
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

    if body["error"]
      @error = body["error"]
    else
      session[:token] = body["access_token"]
      
      user_hash = Faraday.get "https://api.github.com/user" do |req|
        req.headers['Authorization'] = "token " + session[:token]
      end

      session[:current_user]=JSON.parse(user_hash.body)["login"]
      redirect_to repositories_path
    end

    

  end


  def destroy
    session[:token]=nil
    render 'sessions/create'
  end
end