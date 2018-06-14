class RepositoriesController < ApplicationController
  def index
    if logged_in?
      resp = Faraday.get("#{ENV['GITHUB_API_URL']}/users/#{session[:username]}/repos") do |req|
        req.params['sort'] = 'created'
      end
      @resp_hash = JSON.parse(resp.body)      
    end
  end

  def create
    resp = Faraday.post("#{ENV['GITHUB_API_URL']}/user/repos") do |req|
      
      req.body = {name: params[:name]}.to_json
      req.headers['Authorization'] = "token #{session[:github_token]}"
    end
    
    binding.pry
    
    redirect_to root_path
  end
end
