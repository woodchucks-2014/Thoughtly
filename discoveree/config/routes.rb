Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :users do
    resources :categories, :except => ['create']
  end
  post '/categories/create' => 'categories#create'
  get '/login', to: 'sessions#new', as: 'login'
  get '/oauth2callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
