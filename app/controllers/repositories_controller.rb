class RepositoriesController < ApplicationController
  def index
    if logged_in?
      user = Faraday.get('https://api.github.com/user') do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
      end
      @user = JSON.parse(user.body)['login']

      repos = Faraday.get('https://api.github.com/user/repos') do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
      end
      @repos = JSON.parse(repos.body)
      render 'index'
    else
      redirect_to login_path
    end
  end

  def create
    req_hash = { name: params['name']}
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = JSON.generate(req_hash)
    end
    redirect_to root_path
  end
end


# curl -H "Authorization: token b426c3fcf30e9c134292b38106d4eb268145662c" https://api.github.com/user
