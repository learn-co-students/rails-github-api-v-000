class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

   @repos = JSON.parse(resp.body)
   @username = @repos[1]["owner"]["login"]
  end

  def create
  end
end
