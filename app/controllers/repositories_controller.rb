class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = 'token ' + session[:token]
    end

    user_body = JSON.parse(user_resp.body)
    @username = user_body["login"]

    repos_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = 'token ' + session[:token]
    end

    repos_body = JSON.parse(repos_resp.body)
    @repos = repos_body
  end

end
