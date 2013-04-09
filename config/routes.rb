EpicImages::Application.routes.draw do
  root to: 'home#index'

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, only: :create

  get '/about_us', to: 'home#about_us'
  get '/gallery', to: 'home#gallery'
  get '/contact_us', to: 'home#contact_us'
  resources :blogs, only: [:index, :show]

  namespace :admin do
    resource :users, only: [:edit, :update]
    resources :photos
    resources :blogs
    root :to => 'admin#index'
  end

end
