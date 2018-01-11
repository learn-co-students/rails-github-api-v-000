class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(response.body)
  end

   def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end

=begin
Why doesn't this format work...??
  def create
    response = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = "{ 'name': #{params[:name]}}" 
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    redirect_to '/'
  end
=end


end