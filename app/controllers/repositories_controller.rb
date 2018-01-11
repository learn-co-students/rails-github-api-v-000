class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repo_json = JSON.parse(response.body)
  end

  def create
    response = Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = {name: params[:name]}.to_json
      req.headers = {'Authorization' => "token #{session[:token]}"}
    end
    redirect_to root_path
  end
end
