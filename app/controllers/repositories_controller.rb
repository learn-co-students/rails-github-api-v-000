class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]
    end
    @repos = JSON.parse(resp.body)
    @username = @repos[0]["owner"]["login"]
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params['name'] = params[:name]
      req.headers['Authorization'] = session[:token]
    end
    binding.pry
    redirect_to root_path
  end
end
