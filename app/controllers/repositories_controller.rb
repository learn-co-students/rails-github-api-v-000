class RepositoriesController < ApplicationController
  
  def index
  	respforuser = Faraday.get "https://api.github.com/user" do |req|
  		req.headers = {
  			'Authorization': "token #{session[:token]}"
  		}
  	end
  	bodyforuser = JSON.parse(respforuser.body)
  	@user = bodyforuser["login"]

  	respforrepos = Faraday.get "https://api.github.com/user/repos" do |req|
  		req.headers = {
  			'Authorization': "token #{session[:token]}"
  		}
  	end
  	bodyforrepos = JSON.parse(respforrepos.body)
  	@repos = bodyforrepos
  end

  def create
  	resp = Faraday.post "https://api.github.com/user/repos" do |req|
  		req.body = {
  			'name': params[:name]
  		}
  		req.headers = {
  			'Authorization': "token #{session[:token]}",
  			'scope': 'repo'
  		}
  	end
  	binding.pry
  	body = JSON.parse(resp.body)
  	redirect_to root_path
  end

end
