class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{ session[:token] }"
      req.headers['Accept'] = 'application/json'
    end
    user = JSON.parse(resp.body)
    @login = user['login']

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{ session[:token] }"
      req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(resp2.body)


  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{ session[:token] }"
      req.headers['Accept'] = 'application/json'
      req.params["name"] = params[:name]
    end

    body = JSON.parse(resp.body)

    redirect_to root_path, flash: {message: body}

  end

end
