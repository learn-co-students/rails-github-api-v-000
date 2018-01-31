class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    repositories = JSON.parse(resp.body)
    @repositories = Kaminari.paginate_array(repositories).page(params[:page])
    #binding.pry
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {name: params[:name]}.to_json
    end
    redirect_to '/'
  end
end
