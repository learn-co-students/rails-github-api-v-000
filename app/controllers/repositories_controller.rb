class RepositoriesController < ApplicationController
  def index
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers = { 'Authorization' => "token #{session[:token]}" }
    end
    @user = JSON.parse(user_resp.body)["login"]

    repos_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = { 'Authorization' => "token #{session[:token]}" }
    end
    @repos = JSON.parse(repos_resp.body)

    render :index
  end

  def create

    resp = Faraday.post(
      "https://api.github.com/user/repos",
      {name: params[:name]}.to_json,
      {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    )

  
    redirect_to root_path
  end
end
