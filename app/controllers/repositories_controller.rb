class RepositoriesController < ApplicationController

  def index
    # raise "".inspect
    resp_profile = Faraday.get("https://api.github.com/users/anihakutin") do |req|
      req.headers = { 'Authorization':"token #{session[:token]}" }
    end
    resp_repos = Faraday.get("https://api.github.com/users/anihakutin/repos") do |req|
      req.headers = { 'Authorization':"token #{session[:token]}" }
    end

    @user_name = JSON.parse(resp_profile.body)["login"]
    @repos = JSON.parse(resp_repos.body)
    # @token = session[:token]
  end

end
