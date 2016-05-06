class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create  

  def create

# byebug
    gh_id=ENV['GITHUB_ID']
    gh_secret=ENV['GITHUB_SECRET']
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.headers['Accept']='application/json'
      req.body = { 'client_id': gh_id,
                    'client_secret': gh_secret, 
                    'code': params[:code], 
                    }   
    end
# byebug
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
#   byebug
    user_hash = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token " + session[:token]
    end

    session[:current_user]=JSON.parse(user_hash.body)["login"]
 # byebug
#     @user=session[:username]
    redirect_to repositories_path

  end


  def destroy
# byebug
    session[:token]=nil
    # authenticate_user
    # redirect_to root_path
    render 'sessions/create'
  end
end