Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users do
    resources :categories, :except => ['create']
  end
  post '/categories/create' => 'categories#create'
end
