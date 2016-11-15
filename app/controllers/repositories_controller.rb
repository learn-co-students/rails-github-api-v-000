class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @results = JSON.parse(resp.body)
  end

  def create
    # See: http://www.rubydoc.info/gems/faraday
    data = {'name': params[:name]}
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = data.to_json
    end

    redirect_to root_path
  end
end
