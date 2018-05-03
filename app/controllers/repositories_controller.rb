class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
    end

    @repos = JSON.parse(resp.body)

    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers["Authorization"] = "token #{session[:token]}"

    end

    @username = JSON.parse(user_resp.body)["login"]

  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["scope"] = "repo"
      req.headers["Accept"] ="application/json"
      req.body = {
        name: params["name"]
      }.to_json
    end


    redirect_to root_path
  end
end
