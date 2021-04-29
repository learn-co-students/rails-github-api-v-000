class RepositoriesController < ApplicationController
  
  def index
    user = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @user = JSON.parse(user.body)

    repos = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(repos.body)
  end

  def create
    repo = Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = {'name': params[:name]}.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    redirect_to root_path
  end
end
