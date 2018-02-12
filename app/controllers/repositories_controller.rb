class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/users/:username/repos") do |req|
      req.params['username'] = 
      req.params['oauth_token'] = session[:token]
    end
    @results = JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

  def create
  end
end
