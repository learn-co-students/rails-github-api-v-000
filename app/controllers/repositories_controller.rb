class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
    end
    body = JSON.parse(resp.body)
    @user = body['login']

    repos =  Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
    end

    @repo_data = JSON.parse(repos.body)
  end


end
