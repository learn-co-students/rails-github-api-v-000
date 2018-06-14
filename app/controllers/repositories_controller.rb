class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
    req.headers["Authorization"] = "token #{session[:token]}"
  end
  @repos = JSON.parse(resp.body)
  # res = Faraday.get('https://api.github.com/user/repos', {}, {Authorization: "token #{session[:token]}"})
  end

  def  create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.body = {name: "#{params[:name]}"}.to_json
      #why is the code written differently? -
  #     resp = Faraday.post('https://api.github.com/user/repos', {
  #       name: "#{params[:name]}",
  #     }.to_json,
  #   {Authorization: "token #{session[:token]}"},
  # Accept: "application/json"})
    end
    redirect_to root_path
  end
end
