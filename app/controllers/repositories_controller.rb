class RepositoriesController < ApplicationController

  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    repos = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(user.body)
    @username = body["login"]

    @repos_list = JSON.parse(repos.body)
  end

end
