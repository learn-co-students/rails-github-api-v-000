class RepositoriesController < ApplicationController
  def index
    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(resp2.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {
        "name": params[:name],
      }.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    redirect_to root_path
  end

end
