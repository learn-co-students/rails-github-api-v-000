class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    repo_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @username = JSON.parse(user_resp.body)["login"]
    @repositories = JSON.parse(repo_resp.body)
  end
end
