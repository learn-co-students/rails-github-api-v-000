class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(resp.body)
    render :index
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {name: params[:name]}.to_json
    end
    redirect_to '/'
  end
end
