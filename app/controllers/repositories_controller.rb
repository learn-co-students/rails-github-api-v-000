class RepositoriesController < ApplicationController

  # def index
  #   page_num = 1
  #   resp = Faraday.get "https://api.github.com/user/repos?per_page=100&page=#{page_num}", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #   @user_repos = JSON.parse(resp.body)
  #   while !JSON.parse(resp.body).empty?
  #     page_num +=1
  #     resp = Faraday.get "https://api.github.com/user/repos?per_page=100&page=#{page_num}", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #     @user_repos.push(*(JSON.parse(resp.body)) unless resp.body.empty?
  #   end
  #   @user_repos
  # end

  # def index #version that lists all pages fully
  #   @repos = []
  #   page_num = 1
  #   resp = Faraday.get "https://api.github.com/user/repos?per_page=100&page=#{page_num}", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #   while !JSON.parse(resp.body).empty?
  #     resp = Faraday.get "https://api.github.com/user/repos?per_page=100&page=#{page_num}", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #     @repos.push(*(JSON.parse(resp.body)))
  #     page_num +=1
  #   end
  # end

  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
  end

  def create
  end
end
