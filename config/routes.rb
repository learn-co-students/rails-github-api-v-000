Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth', to: 'sessions#create'
    post '/repositories/create', to: 'repositories#create'
    root 'repositories#index'
end