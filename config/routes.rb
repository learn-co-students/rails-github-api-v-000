Rails.application.routes.draw do
  get '/auth' => 'sessions#create' #makes a call to sessions controller, create method
  post '/repositories/create' => 'repositories#create'
  root 'repositories#index'

end
