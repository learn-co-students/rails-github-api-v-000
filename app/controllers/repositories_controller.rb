# class RepositoriesController < ApplicationController

#   def index
#     resp = Faraday.get("https://api.github.com/user/repos") do |req|
#     req.headers = { 'Accept': 'application/json', 'Authorization': "token #{session[:token]}" }
#       end
#       @body = JSON.parse(resp.body)
#   end

#   def create
#     resp = Faraday.post("https://api.github.com/user/repos") do |req|
#       req.body = { name: params["name"] }.to_json
#       req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}" }
#       end

#   end


# end



class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
