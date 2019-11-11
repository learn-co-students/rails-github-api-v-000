class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    # repo_resp = Faraday.get "https://api.github.com/user/repos" do |req|
    #   req.headers['Authorization'] = "token #{session[:token]}"
    # end

    @login = JSON.parse(user_resp.body)
    # binding.pry
    @username = @login["login"]
    # @repos = @login[""]

    render 'index'
  end

end
