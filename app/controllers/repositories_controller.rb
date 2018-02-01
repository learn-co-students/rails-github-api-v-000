class RepositoriesController < ApplicationController
  def index
  	user = Faraday.get("https://api.github.com/user") do |req|
  		req.params[:access_token] = session[:token]
  	end
  	@username = JSON.parse(user.body)['login']

  	@repositories = Faraday.get("https://api.github.com/users/#{@username}/repos") do |req|
  		req.params[:access_token] = session[:token]
  	end

  	@repositories = JSON.parse(@repositories.body)
  	@repositories = Kaminari.paginate_array(@repositories).page(params[:page]).per(10)
  end

  def create
  	body = {
  	  "name": "#{params[:name]}",
  	  "description": "created from other app with OAuth",
  	  "private": false,
  	  "has_issues": true,
  	  "has_projects": true,
  	  "has_wiki": true
  	}
  	body = JSON[body]

  	Faraday.post("https://api.github.com/self/repo") do |req|
  		req.params[:body] = body
  		req.params[:access_token] = session[:token]
  	end
  	redirect_to '/'
  end
end
