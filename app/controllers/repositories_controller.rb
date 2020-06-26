class RepositoriesController < ApplicationController

  def index
    response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    @repos_array = body
    session[:name] = body[0]["owner"]["login"]
  end

  

end
