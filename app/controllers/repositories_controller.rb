class RepositoriesController < ApplicationController

  def index
    user = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user_info = JSON.parse(user.body)

    repo = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repo_info = JSON.parse(repo.body)

  end

end
