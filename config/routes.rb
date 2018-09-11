Rails.application.routes.draw do
  resources :categories
  get 'sessions/new'
  get 'welcome/index'
  root 'welcome#index'

  get    '/registration', to: 'users#new'
  post   '/registration', to: 'users#create'
  get    '/login',        to: 'sessions#new'
  post   '/login',        to: 'sessions#create'
  delete '/logout',       to: 'sessions#destroy'

#  resources :users, param: :serial

  get '/blogs/:blog_id/comments/new', to: 'comments#new', as: :new_blog_comment
  post '/blogs/:blog_id/comments/new', to: 'comments#create', as: :create_blog_comment

  get '/comments/:comment_id/new', to: 'comments#new', as: :new_comment
  get '/comments/:comment_id/edit', to: 'comments#edit', as: :edit_comment
  delete '/comments/:comment_id', to: 'comments#destroy', as: :delete_comment

  resources :blogs do
    resources :comments, except: [:new]
  end

#  get '/users/:serial/edit_password', to: "users#edit_password", as: :edit_password
#  patch '/users/:serial/update_password', to: "users#update_password", as: :update_password

  resources :users, param: :serial do
    member do
      get :edit_password, as: :edit_password
      patch :update_password, as: :update_password
    end
  end

  match 'users/:serial/update' => 'users#update', :via => :patch, :as => :update_user
  patch "/languages", to: "languages#update", :as => :update_language

end
