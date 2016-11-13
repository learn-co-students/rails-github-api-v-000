class RepositoriesController < ApplicationController
  def index
    @user = session[:username]
    binding.pry
  end

  def create
  end
end
