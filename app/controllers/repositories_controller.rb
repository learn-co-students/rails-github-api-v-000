class RepositoriesController < ApplicationController

  def index
    url = "https://api.github.com/user?access_token=#{session[:token]}"
    info = Faraday.get(url)
    body = JSON.parse(info.body)
    @username = body["login"]

    reposURL = "https://api.github.com/users/#{@username}/repos"
    repo_info = Faraday.get(reposURL) do |req|
      req.params[:per_page] = 50
    end
    @repos = JSON.parse(repo_info.body)
  end

end

# Change WebMock.disable_net_connect!(allow_localhost: true) to WebMock.allow_net_connect! in spec_helper.rb on line 35
