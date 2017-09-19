class RepositoriesController < ApplicationController
  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @username = JSON.parse(user.body)["login"]

    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    repos = JSON.parse(repos.body)
    @repos = Kaminari.paginate_array(repos).page(params[:page])
  end

  def create
    #not working with github
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {
        "name" => params["name"]
      }.to_json
    end

    redirect_to root_path
  end
end
