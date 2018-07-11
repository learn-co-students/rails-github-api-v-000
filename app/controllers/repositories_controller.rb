class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token] 
    end
    @body = JSON.parse(resp.body)
  end

  def create
  end
end
