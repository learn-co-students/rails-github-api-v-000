class RepositoriesController < ApplicationController

  def index

      login_resp = Faraday.get("https://api.github.com/user") do |req|
          req.params['access_token'] = session['token']
      end
      @login = JSON.parse(login_resp.body)['login']
      repos_resp = Faraday.get("https://api.github.com/user/repos") do |req|
          req.params['access_token'] = session['token']
          params['username'] = @login
      end
      @repos = JSON.parse(repos_resp.body)
  end

  def create

      name = params['name']
      access_token = session[:token]
      create_repo_resp = Faraday.post('https://api.github.com/users/repos') do |req|
          req.body = {
              'name': name,
          }

          req.headers['Authorization'] = 'token ' + access_token
          binding.pry

      end
      binding.pry
      redirect_to root_path
  end

end
