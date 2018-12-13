class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      #req.params['oauth_token'] = session[:token]
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @user = JSON.parse(resp.body)
    @name = @user["login"]

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      #req.params['oauth_token'] = session[:token]
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp2.body)
    #binding.pry
  end

end
