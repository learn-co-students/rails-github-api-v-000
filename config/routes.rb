Rails.application.routes.draw do
  root 'repositories#index'
  get  '/repositories/index'  => 'repositories#index'
  post '/repositories/create' => 'repositories#create'
  
  get '/auth' => 'sessions#create'
end
