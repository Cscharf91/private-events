Rails.application.routes.draw do
  resources :events
  root to: 'events#index'
  resources :users
  resources :sessions, only: [:create, :new, :destroy]
  get '/signup', to: 'users#new'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  post '/attend', to: 'event_attendances#create'
  get '/attend', to: 'event_attendances#create'
  delete '/unattend', to: 'event_attendances#destroy'

  get '/invite', to: 'invites#new'
  post '/invite', to: 'invites#create'
  get '/notifications', to: 'invites#show'
  get '/uninvite', to: 'invites#destroy'
  get '/notifications', to: 'invites#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
