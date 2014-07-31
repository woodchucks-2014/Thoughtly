Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/users/login', to: 'users#sign_in_page'
  post '/users/login', to: 'users#login'
  get '/users/signup', to: 'users#sign_up_page'
  post '/users', to: 'users#create', :as => 'sign_up'
  post '/categories/create' => 'categories#create'
  get '/users/logout', to: 'users#logout', :as => 'logout'

  resources :users do
    resources :categories, :except => ['create']
  end

  post '/categories/create' => 'categories#create'

  post '/categories/nodegraph' => 'categories#nodegraph'


  post "/categories/childnodes" => 'categories#childnodes'

  get '*missing' => redirect('/')

end
