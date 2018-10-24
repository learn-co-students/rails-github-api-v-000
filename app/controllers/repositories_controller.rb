class RepositoriesController < ApplicationController

  def index
    username = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @username_results = JSON.parse(username.body)

    repos = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @results = JSON.parse(repos.body)
  end

  def create
  end

end
