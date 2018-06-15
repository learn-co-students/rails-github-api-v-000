class RepositoriesController < ApplicationController
  def index
    @repos = ['Repo 1', 'Repo 2', 'Repo 3']
  end

  def create
    Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session['token']}"
      req.body = { name: params['name'] }.to_json
    end
    redirect_to '/'
  end
end
