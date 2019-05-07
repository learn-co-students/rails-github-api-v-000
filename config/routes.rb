Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'repositories#index'
  get '/auth' => 'sessions#create'
  post '/repositories/create' => 'repositories#create'
    
end
