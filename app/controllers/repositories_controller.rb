class RepositoriesController < ApplicationController
  def index
    repo_response = Faraday.get "https://api.github.com/user/repos?sort=created",
      {},
      {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    @repos_array = JSON.parse(repo_response.body)
  end

  def create
    Faraday.post "https://api.github.com/user/repos",
      {name: "#{params[:name]}"}.to_json,
      {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    redirect_to '/'
  end
end
