Rails.application.routes.draw do
  get '/auth' => 'sessions#create'
  post '/repositories/create' => 'repositories#create'
  root 'repositories#index'
  get '/logout' => 'sessions#destroy'
end