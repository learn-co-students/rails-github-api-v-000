Rails.application.routes.draw do


  root 'repositories#index'

  get '/auth' => 'sessions#create'

  post '/repositories/create' => 'repositories#create'

end
