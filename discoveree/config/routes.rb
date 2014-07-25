Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do get 'root' => 'devise/sessions#new'
  end
  resources :users do
    resources :categories
  end
end
