class RepositoriesController < ApplicationController
  
  def index
    unless !logged_in? 
      user_response = Faraday.get "https://api.github.com/user" do |req|
          req.headers["authorization"] = "token #{session[:token]}"
          req.headers["Accept"] = "application/json"
      end 
      
      repo_response = Faraday.get "https://api.github.com/user/repos" do |req|
        req.headers["authorization"] = "token #{session[:token]}"
        req.headers["Accept"] = "application/json"
      end 
    
      @username = JSON.parse(user_response.body)["login"]
       
      repo_response = JSON.parse(repo_response.body)

      @repos = repo_response.collect do | repo |
        repo["name"]
        end 
       
       
    end 
    
  end
  

end
