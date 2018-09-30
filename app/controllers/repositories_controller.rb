class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      # binding.pry
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    user = Faraday.get "https://api.github.com/user" do |req|
      # binding.pry
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @user = JSON.parse(user.body)
    @body = JSON.parse(resp.body)
  end

end
