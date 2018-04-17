class RepositoriesController < ApplicationController
  def index

  end

  def create
    # binding.pry
    # resp = Faraday.post do |req|
    #   req.url "https://api.github.com/user/repos"
    #   req.headers['Authorization'] = "token #{session[:token]}"
    #   req.headers['Accept'] = 'application/json'
      
    #   req.body = { name: params[:name] }
    #   req.body = { name: "testtest" }.to_json
    # end

    # redirect_to '/'

    response = Faraday.post "https://api.github.com/user/repos", { name: "testtest" }, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    binding.pry
    redirect_to '/'
  end
end
