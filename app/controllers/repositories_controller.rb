class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    @user_info = JSON.parse(user.body)

    repos = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    @repo_list = JSON.parse(repos.body)

  end

end
