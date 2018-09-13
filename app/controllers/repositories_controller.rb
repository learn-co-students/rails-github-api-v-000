class RepositoriesController < ApplicationController

  def index
    login = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @user_login = JSON.parse(login.body)

    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(repos.body)
    binding.pry

  end

end
