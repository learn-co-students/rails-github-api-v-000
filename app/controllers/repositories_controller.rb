class RepositoriesController < ApplicationController
  def index
    res = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(res.body)
  end

  def create
    res = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = { name: params[:name]}.to_json
    end
   redirect_to '/'
  end
end
