class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @user = JSON.parse(user_resp.body)

    repos_resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @user_repos = JSON.parse(repos_resp.body)
  end
end
