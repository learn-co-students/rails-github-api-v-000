class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
    #binding.pry
    session[:username] = @repos[1]["owner"]["login"]
  end

end
