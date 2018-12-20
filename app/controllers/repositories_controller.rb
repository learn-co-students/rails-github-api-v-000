class RepositoriesController < ApplicationController


  def index
 
     response = Faraday.get "https://api.github.com/user/repos" do |req|
 # binding.pry
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = 'token ' + session[:token]
      # Faraday.get "https://api.github.com/user/repos" do |req|

      # end
    end
    @body = JSON.parse(response.body)
   
  end

  def github_search
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['q'] = params[:query]
    end

    body = JSON.parse(@resp.body)
    @items = body["items"]
    render 'index'
  end

end
