class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.body['access_token'] = session[:token]
    end
    @repos = JSON.parse(resp.body)
  end

end
