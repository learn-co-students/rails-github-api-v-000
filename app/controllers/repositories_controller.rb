class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/JSON'
    end

    @user = JSON.parse(resp.body)

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/JSON'
    end

    @repos = JSON.parse(resp2.body)

  end

end
