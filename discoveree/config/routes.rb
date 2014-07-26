Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/users/login', to: 'users#sign_in_page'
  post '/users/login', to: 'users#login'
  get '/users/signup', to: 'users#sign_up_page'
  get '/users/:id/destroy', to: 'users#destroy', :as => "logout"
  post '/users', to: 'users#create', :as => 'sign_up'
  post '/categories/create' => 'categories#create'
  resources :users do
    resources :categories, :except => ['create']
  end
end
