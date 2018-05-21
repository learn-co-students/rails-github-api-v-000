class RepositoriesController < ApplicationController
  def index
    resp1 = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {
        Authorization: "token #{session[:token]}"
      }
    end
    body1 = ActiveSupport::JSON.decode(resp1.body)
    @username = body1["login"]

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {
        Authorization: "token #{session[:token]}"
      }
    end
    @repos = ActiveSupport::JSON.decode(resp2.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {
        Authorization: "token #{session[:token]}"
      }
      req.body = ActiveSupport::JSON.encode({"name" => params[:name]})
    end
    render "index"
  end
end
