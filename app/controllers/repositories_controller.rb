class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req['Authorization'] = "token #{session[:token]}"
      req['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
    # binding.pry
  end

  def create
  end
end
