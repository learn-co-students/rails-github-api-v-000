class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    resp = Faraday.get "https://api.github.com/user", { access_token:  session[:token] },
      { 'Accept' => 'application/json'}

    body = JSON.parse(resp.body)

    #binding.pry

    @username = body["login"]

    resp = Faraday.get "https://api.github.com/users/#{@username}/repos", { access_token:  session[:token] },
      { 'Accept' => 'application/json'}

    body = JSON.parse(resp.body)

    @repo_names = []

    body.each do |repo|
      @repo_names << repo["name"]
    end


  end

  def create
  end
end

