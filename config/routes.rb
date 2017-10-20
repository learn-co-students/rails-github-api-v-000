Rails.application.routes.draw do
  get '/auth' => 'sessions#create'
  post '/repositories/create' => 'repositories#create'
  root 'repositories#index'

  post '/', to: 'repositories#github_search'

end
