class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      access_token = session[:token]
      req.params['access_token'] = access_token
    end
    @body = JSON.parse(resp.body)

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      access_token = session[:token]
      req.params['access_token'] = access_token
    end

    @repos = JSON.parse(resp2.body)
  end

  # def create
  # end

end
