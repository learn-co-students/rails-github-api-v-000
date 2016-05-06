class RepositoriesController < ApplicationController
  require 'json'

  before_action :authenticate_user
  before_action :set_user

  def index
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.params["sort"] = "created"
    end

    @repos=JSON.parse(resp.body)
  end

  def create
    build_data

    create_resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.body = @data.to_json
    end

    new_repo=JSON.parse(create_resp.body)

    redirect_to repositories_path
  end

  private

    def build_data
      @data={
        "name": params[:name]
      }
    end

    def set_user
      @user||=session[:current_user]
    end
end
