class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers[:authorization] = "token #{session[:token]}"
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    body_hash = {name: params[:name]}
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers[:authorization] = "token #{session[:token]}"
      req.body = JSON.generate(body_hash)
    end
    redirect_to root_path
  end

end
