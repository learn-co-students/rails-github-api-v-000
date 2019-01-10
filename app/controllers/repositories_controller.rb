class RepositoriesController < ApplicationController

  def create
    response = Faraday.post "https://api.github.com/user/repos" do |req|
      # req.body = {"name": "#{params[:name]}", "scope": "repo"}
      # # req.params["scope"] = "repo"
      # req.headers = {"Authorization": "token #{session[:token]}"}
      req.body = { 'name': params[:name] }.to_json
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    redirect_to root_path
    # binding.pry
  end

  def index
    response = Faraday.get "https://api.github.com/user" do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end

    repos_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end

    @user = JSON.parse(response.body)['login']
    @repo_body = JSON.parse(repos_response.body)
  end

end
