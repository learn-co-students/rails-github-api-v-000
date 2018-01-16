class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
    #binding.pry
  end

 def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    binding.pry
    redirect_to '/'
  end
end



=begin

class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end




    #binding.pry
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      #req.headers['Accept'] = 'application/json'
      req.params['oauth_token'] = session[:token]
    end
    binding.pry
    @repos = JSON.parse(resp.body)
    
    @name = params[:name].to_json
=end 