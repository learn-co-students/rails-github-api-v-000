class RepositoriesController < ApplicationController
  
  # GET /user
  def index
    resp = Faraday.get("https://github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token] 
      req.headers['Accept'] = 'application/json'
    end

    @user = JSON.parse(resp.body)

    repos = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(repos.body)
  end

end
