Rails.application.routes.draw do
  resources :categories
  get 'sessions/new' # TODO FL elérhető /sessions/new és /login útvonalon is?
  get 'welcome/index' # TODO FL elérhető localhost:3000/welcome/index útvonalon is?
  root 'welcome#index'

  get    '/registration', to: 'users#new'
  post   '/registration', to: 'users#create'
  get    '/login',        to: 'sessions#new'
  post   '/login',        to: 'sessions#create'
  delete '/logout',       to: 'sessions#destroy'

  get '/posts/:post_id/comments/new', to: 'comments#new', as: :new_post_comment
  post '/posts/:post_id/comments/new', to: 'comments#create', as: :create_post_comment # TODO FL new => create???

  get '/comments/:comment_id/new', to: 'comments#new', as: :new_comment
  get '/comments/:comment_id/edit', to: 'comments#edit', as: :edit_comment # TODO FL no, itt a :comment_id teljesen zavaró - olyan, mintha a fölötte lévőhöz hasonlóan ez is nested lenne
  delete '/comments/:comment_id', to: 'comments#destroy', as: :delete_comment # TODO FL ennek kell külön route helper?

  resources :posts do
    resources :comments, except: [:new]
  end

  resources :users, param: :serial do
    member do # TODO FL ez inkább a current_user-re vonatkozik, nem? vagy admin bárkinek módosíthatja serial alapján a jelszavát?
      get :edit_password, as: :edit_password
      patch :update_password, as: :update_password
    end
  end

  match 'users/:serial/update' => 'users#update', :via => :patch, :as => :update_user # TODO FL kell a /update?
  patch "/languages", to: "languages#update", :as => :update_language

end
