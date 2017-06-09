class RepositoriesController < ApplicationController
  def index
    response = Faraday.get('https://api.github.com/user/repos') do |request|
      request.headers = {Authorization: "token #{session[:token]}"}
    end
    @body = JSON.parse(response.body)

    user = Faraday.get("https://api.github.com/user") do |request|
      request.headers = {Authorization: "token #{session[:token]}"}
    end

    @user = JSON.parse(user.body)
  end

  def create
    response = Faraday.post('https://api.github.com/user/repos') do |request|
      request.headers = {Authorization: "token #{session[:token]}"}
      request.body = {"name" => params[:name] }.to_json
    end
    redirect_to root_path

  end
end
