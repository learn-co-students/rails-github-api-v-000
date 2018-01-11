class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @repositories = JSON.parse(resp.body)
  end

  def create
    # response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    # response = Faraday.post("https://api.github.com/user/repos") do |req|
    #   req.headers['Accept'] = 'application/json'
    #   req.headers['Authorization'] = "token #{session[:token]}"
    #   req.body = {name: params[:name]}
    # end

    # response = Faraday.post("https://api.github.com/user/repos") do |req|
    #   req.headers['Accept'] = 'application/json'
    #   req.headers['Authorization'] = "token #{session[:token]}"
    #   req.body = {name: params[:name]}
    # end

    redirect_to root_path
  end

end
