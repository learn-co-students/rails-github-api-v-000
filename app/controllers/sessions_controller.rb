class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    session[:token] = sessions_params[:code]
    redirect_to "/"
  end
  
  def sessions_params
    params.permit(:code)
  end 
end
