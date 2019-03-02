class RepositoriesController < ApplicationController
  require "pry"
  
  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @user_data = JSON.parse(user.body)

    repos = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repo_data = JSON.parse(repos.body)
  end

  def create
    name = params[:name]
    new_repo = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
      req.body = {'name': name, 'description': "creating repos with APIs and OAuth."}.to_json
    end
    redirect_to '/'
  end

end
