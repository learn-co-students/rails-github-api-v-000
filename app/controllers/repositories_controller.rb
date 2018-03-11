class RepositoriesController < ApplicationController

  def index
    repos_resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers = {"Authorization" => "token #{session[:token]}"}
    end
    @repos = JSON.parse(repos_resp.body)
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers = {
        "Authorization" => "token #{session[:token]}",
        "Accept" => 'application/json'
      }
      req.body = {'name' => "#{params[:name]}"}.to_json
    end
    redirect_to root_path
  end
end
