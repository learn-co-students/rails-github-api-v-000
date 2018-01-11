class RepositoriesController < ApplicationController
  def index
    base_url = "https://api.github.com/"

    user_resp = Faraday.get(base_url + "user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    repos_resp = Faraday.get(base_url + "user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @username = JSON.parse(user_resp.body)["login"]
    @repos = JSON.parse(repos_resp.body)
  end

  def create
    url = "https://api.github.com/user/repos"

    resp = Faraday.post(url) do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      req.body = {'name': params['name']}.to_json
    end

    redirect_to root_path
  end
end
