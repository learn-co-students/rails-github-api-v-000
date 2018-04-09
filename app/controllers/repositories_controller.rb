class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers = {
        'Accept' => 'application/json',
        'Authorization' => "token #{session[:token]}"
      }
      req.body = {'name' => params[:name]}
    end
    redirect_to root_path
  end
end
