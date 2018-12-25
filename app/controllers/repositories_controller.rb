class RepositoriesController < ApplicationController
  # skip_before_action :authenticate_user

  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
  
    @user_data = JSON.parse(user.body)
  
    repos = Faraday.get("https://api.github.com/user/repos") do |req|

      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
   
    @repo_data = JSON.parse(repos.body)
  end

  def whuttheheck
    session.clear
  end

  def create
    response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    redirect_to '/'
  end
end

    # resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      #   req.params['oauth_token'] = session[:token]
      #   req.params['text'] = params[:new_repo]
   
      # redirect_to repositories_path
    # end

    # body = JSON.parse(resp.body)
    # session[:token] = body["access_token"]
    # redirect_to root_path
