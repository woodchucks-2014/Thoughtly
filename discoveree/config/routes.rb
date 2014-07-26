Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'
  resources :users do
    resources :categories, :except => ['create']
  end
  post '/categories/create' => 'categories#create'
end
