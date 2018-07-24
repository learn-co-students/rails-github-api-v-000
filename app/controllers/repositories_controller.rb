
class RepositoriesController < ApplicationController

  def index
  	conn = Faraday.new("https://api.github.com")
  	
  	resp = conn.get do |req|
  		req.url '/user'
  		req.headers['Content-Type'] = 'application/json'
  		req.headers['Authorization'] = "token #{session[:token]}"
  		req.params[:access_token] = session[:token]
  	end

  	@user = JSON.parse(resp.body)['login']

  	resp = conn.get do |req|
  		req.url '/user/repos'
  		req.headers['Content-Type'] = 'application/json'
  		req.headers['Authorization'] = "token #{session[:token]}"
  		req.params[:access_token] = session[:token]
  	end

  	@repos = []
  	JSON.parse(resp.body).each do |item|
  		response_hash = {}
  		response_hash[:name] = item['name']
  		response_hash[:url] = item['html_url']
  		@repos << response_hash
  	end

  end

  def create
  	conn = Faraday.new("https://api.github.com")

  	resp = conn.post do |req|
  		req.url '/user/repos'
  		req.headers['Content-Type'] = 'application/json'
  		req.headers['Authorization'] = "token #{session[:token]}"
  		req.body = {'name': params[:name]}.to_json
  	end

  	redirect_to root_path
  end

end