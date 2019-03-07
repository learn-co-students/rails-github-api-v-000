class RepositoriesController < ApplicationController

  def index

    user_response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user = JSON.parse(user_response.body)


    repo_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(repo_response.body)
    
  end

end
