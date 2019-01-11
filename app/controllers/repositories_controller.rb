class RepositoriesController < ApplicationController
  
  def index
    @page = params[:page] || 1
    res = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params["page"] = @page
      # req.params['per_page'] = 100
      req.headers = {
        Authorization: "token #{session[:token]}"
      }
    end
    @repos = JSON.parse(res.body)
  end

  def create
    # res = Faraday.post("https://api.github.com/user/repos") do |req|
    #   req.headers = {
    #     Authorization: "token #{session[:token]}",
    #     Accept: 'application/json'
    #   }
    #   req.body = {'name': params[:name] }.to_json
    # end
    response = Faraday.post 'https://api.github.com/user/repos' do |req|
      req.body = { 'name': params[:name] }.to_json
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    raise respose.body
    redirect_to root_path
  end

end
