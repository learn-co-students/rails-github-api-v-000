class RepositoriesController < ApplicationController
  def index
    response = Faraday.get('https://api.github.com/user/repos') do |request|
      request.headers = {Authorization: "token #{session[:token]}"}
    end
    @body = JSON.parse(response.body)
  end

  def create
  end
end
