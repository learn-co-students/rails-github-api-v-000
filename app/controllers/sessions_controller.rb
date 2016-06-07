class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  
  def create
    raise "in sessions#create"
  end

end