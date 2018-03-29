
class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end

  # def index
  #   resp3 = Faraday.get "https://api.github.com/user/repos" do |req|
  #     req.headers['Authorization'] = "token #{session[:token]}"
  #     req.headers['Accept'] = 'application/json'
  #   end
  #
  #   @repos = JSON.parse(resp3.body)
  # end
  #
  #
  # def create
  #   response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #   redirect_to '/'
  # end

end
