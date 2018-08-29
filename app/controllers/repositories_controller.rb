class RepositoriesController < ApplicationController

  def index
    authenticate_user
    
  end

end
