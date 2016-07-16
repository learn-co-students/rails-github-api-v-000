class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      #req.params['oauth_token'] = "#{session[:token]} OAUTH_TOKEN"
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    create_resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
        req.body = {"name": "#{params[:name]}"}.to_json
    end

    binding.pry
    redirect_to root_path
  end
end
