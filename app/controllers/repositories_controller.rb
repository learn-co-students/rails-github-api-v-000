class RepositoriesController < ApplicationController
  before_action :authenticate_user
  
  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
  end

end
