class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get 'https://api.github.com/user/repos', {}, { 'Authorization': "token #{session[:token]}", 'Accept': 'application/json' }

    # raise JSON.parse(resp.body).inspect

    @repos = Kaminari.paginate_array(JSON.parse(resp.body)).page(params[:page])
  end

  def create
    resp = Faraday.post 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      req.body = { 'name': params[:name] }.to_json
    end
    redirect_to root_path
  end
end
