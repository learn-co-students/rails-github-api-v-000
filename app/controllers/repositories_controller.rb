class RepositoriesController < ApplicationController

  def index
    page = "?page=#{params[:page]}"
    github = GithubService.new(session)
    @username = github.get_username
    @repos = github.get_repos(page)
    @links = github.links
  end

  def create
    github = GithubService.new(session)
    github.create_repo(params[:name])
    redirect_to root_path
  end
end
