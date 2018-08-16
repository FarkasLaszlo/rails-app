Rails.application.routes.draw do
  get 'sessions/new'
  get 'welcome/index'
  root 'welcome#index'

  get    '/registration', to: 'users#new'
  get    '/login',        to: 'sessions#new'
  post   '/login',        to: 'sessions#create'
  delete '/logout',       to: 'sessions#destroy'
  resources :users, param: :serial
  resources :blogs do
    resources :comments
  end
end
