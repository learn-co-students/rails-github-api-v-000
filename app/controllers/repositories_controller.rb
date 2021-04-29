class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @username = JSON.parse(user_resp.body)["login"]

    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
  end

end
