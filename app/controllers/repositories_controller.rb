class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.params['access_token'] = session[:token]
    end

    @repos = JSON.parse(resp.body)
    @username = current_user_info['login']
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers['accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {
        "name": params[:name]
      }.to_json
    end
    body = JSON.parse(resp.body)
    if !resp.success?
      flash[:message] = "The repository was not created."
    elsif resp.success?
      flash[:message] = "The repository was created."
    end
    redirect_to root_path
  end
end
