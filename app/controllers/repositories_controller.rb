class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]

    end
    @username = JSON.parse(resp.body)["response"]["friends"]["items"]

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
    end
    @repos = JSON.parse(resp.body)["response"]["repositories"]
  end

end
