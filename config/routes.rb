EpicImages::Application.routes.draw do
  root to: 'home#index'

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, only: :create

  get '/about_us', to: 'home#about_us'
  get '/contact_us', to: 'home#contact_us'
  resources :blogs, only: [:index, :show]
  resources :tags, path: 'gallery', only: [:index, :show]
  get 'photos/search' => 'tags#search', as: :photos_search

  namespace :admin do
    resource :users, only: [:edit, :update]
    resources :photos, except: [:new, :show] do
      put :update_all, on: :collection
    end
    resources :blogs
    resources :tags, path: 'galleries', only: [:show, :create]
    root :to => 'admin#index'
  end

end
