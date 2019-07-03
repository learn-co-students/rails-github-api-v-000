Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth' => 'sessions#create'
  get "/login/oauth/authorize" => 'repositories#index'
  post '/repositories/create' => 'repositories#create'
  root 'repositories#index'
end
