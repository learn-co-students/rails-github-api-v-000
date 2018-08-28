class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get "https://api.github.com/user" do |req|
        req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @user = JSON.parse(resp.body)

    repo_url = 'https://api.github.com/users/' + @user["login"] + '/repos'
    resp = Faraday.get repo_url do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repoList = JSON.parse(resp.body)
  end
end
