class RepositoriesController < ApplicationController

  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    body = JSON.parse(response.body)

  if response.success?
    @repos = body
  else
    @error = body["meta"]["errorDetail"]
  end

  render 'index'

  rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
    render 'search'
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
        redirect_to '/'
    end

end
