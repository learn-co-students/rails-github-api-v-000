class RepositoriesController < ApplicationController

  def index
     @resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end
      @login = JSON.parse(@resp.body)["login"]
      @response = Faraday.get("https://api.github.com/user/repos") do |req|
        req.headers['Authorization'] = "token " + session[:token]
        req.headers['Accept'] = 'application/json'
      end
        @repos = JSON.parse(@response.body)
        redirect_to root_path
  end

end
