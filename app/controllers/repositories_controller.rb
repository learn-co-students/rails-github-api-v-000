class RepositoriesController < ApplicationController
  def index
    # response = Faraday.get "https://api.github.com/user/repos", {sort: "created"}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}"}
  @repos = JSON.parse(response.body)

    # user_resp = Faraday.get "https://api.github.com/user/", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # @user_info = JSON.parse(user_resp.body)
  end

  def create
    # Faraday.post "https://api.github.com/user/repos", {name: params[:name], description: "test repo create via api"}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}"}
    redirect_to root_path
  end
end
