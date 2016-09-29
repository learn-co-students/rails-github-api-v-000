class RepositoriesController < ApplicationController
  def index

    response = Faraday.get('https://api.github.com/user/repos') do |req|
      req.params[:access_token] = session[:token]
    end

    @repos = JSON.parse(response.body)
    @username = @repos.first["owner"]["login"]
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos",
      {name: params[:name]}.to_json,
      {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    redirect_to root_path
  end
end
