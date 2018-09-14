Rails.application.routes.draw do
  resources :categories
  root 'welcome#index'

  get    '/registration', to: 'users#new'
  post   '/registration', to: 'users#create'
  get    '/login',        to: 'sessions#new'
  post   '/login',        to: 'sessions#create'
  delete '/logout',       to: 'sessions#destroy'

  get '/posts/:post_id/comments/new', to: 'comments#new', as: :new_post_comment
  post '/posts/:post_id/comments/create', to: 'comments#create', as: :create_post_comment

  get '/comments/:comment_id/new', to: 'comments#new', as: :new_comment
  get '/comments/:id/edit', to: 'comments#edit', as: :edit_comment

  resources :posts do
    resources :comments, except: [:new]
  end

  resources :users, param: :serial

  get "/edit_password", to: 'users#edit_password', as: :edit_password
  patch "/update_password", to: "users#update_password", as: :update_password

  match 'users/:serial' => 'users#update', :via => :patch, :as => :update_user
  patch "/languages", to: "languages#update", :as => :update_language

end
