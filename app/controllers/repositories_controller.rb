class RepositoriesController < ApplicationController
  
  def index
    resp_user = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user_data = JSON.parse(resp_user.body)

    resp_repo = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repo_data = JSON.parse(resp_repo.body)
  end

end
