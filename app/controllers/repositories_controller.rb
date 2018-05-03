class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post 'https://api.github.com/user/repos' do |req|
      req.headers = {Authorization: "token #{session[:token]}",
      Accept: 'application/json'}
      req.body = {name: params[:name]}.to_json
      binding.pry
    end
    redirect_to root_path
  end
end
