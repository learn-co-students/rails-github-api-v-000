class RepositoriesController < ApplicationController
  
  def index
    access_token = session[:token]
    resp = Faraday.get("https://api.github.com/user?access_token=#{access_token}")
    body = JSON.parse(resp.body)
    binding.pry
    render 'index'
  end

end
