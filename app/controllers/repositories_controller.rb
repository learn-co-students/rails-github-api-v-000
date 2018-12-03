class RepositoriesController < ApplicationController
  
  def index
    user_resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = 'token ' + session[:token]
    end
    @user = JSON.parse(user_resp.body)

    repo_resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = 'token ' + session[:token]
    end
    @repos = JSON.parse(repo_resp.body)
  end

end
