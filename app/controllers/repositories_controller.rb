class RepositoriesController < ApplicationController
  def index
    @username = session[:username]
    response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(response.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      # req.params["scope"] = 'public_repo'
      req.body = {"name" => params["name"]}.to_json
    end
    # result = JSON.parse(resp.body)
    redirect_to '/'
  end
end
