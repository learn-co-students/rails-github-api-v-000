class RepositoriesController < ApplicationController

  def index
    access_token = session[:token]
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{access_token}"}
    end
    @repos = JSON.parse(resp.body)
  end



end
