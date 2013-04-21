EpicImages::Application.routes.draw do
  root to: 'home#index'

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, only: :create

  get '/about_us', to: 'home#about_us'
  get '/contact_us', to: 'home#contact_us'
  resources :blogs, only: [:index, :show]
  # resources :galleries, path: 'gallery', only: [:index, :show]
  resources :tags, path: 'gallery', only: [:index, :show]
  get 'photos/search' => 'tags#search', as: :photos_search

  namespace :admin do
    resource :users, only: [:edit, :update]
    resources :photos
    resources :blogs
    resources :galleries
    root :to => 'admin#index'
  end

end
