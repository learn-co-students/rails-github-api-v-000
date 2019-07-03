class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params["oauth_token"] = session[:token]
    end
    @username = JSON.parse(resp.body)["login"]

    response = Faraday.get("https://api.github.com/user/repos") do |request|
      request.params["oauth_token"] = session[:token]
    end
    @repos = JSON.parse(response.body)
  end

end
