class RepositoriesController < ApplicationController
  before_action :set_user

  def index
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
    end

    @repos=JSON.parse(resp.body)
  end

  def create
  end

  private

    def set_user
      @user||=session[:current_user]
    end
end
