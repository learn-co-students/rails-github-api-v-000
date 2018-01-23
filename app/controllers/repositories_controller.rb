class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    resp = Faraday.get "https://api.github.com/user/repos", {},
      { 'Accept' => 'application/json', 'Authorization' => "token #{session[:token]}"}

    body = JSON.parse(resp.body)

    @repo_names = []

    body.each do |repo|
      @repo_names << repo["name"]
    end

  end

  def create
    repo_name = params[:name]

    resp = Faraday.post "https://api.github.com/user/repos", { name: repo_name }.to_json,
      { 'Authorization' => "token #{session[:token]}"}



    redirect_to root_path
  end
end

