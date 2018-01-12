class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {
        "Authorization": "token #{session[:token]}",
      }
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    Faraday.post("https://api.github.com/user/repos",
      {"name": params[:name]}.to_json,
      {'Authorization': "token #{session[:token]}"}
    )
  end
end
