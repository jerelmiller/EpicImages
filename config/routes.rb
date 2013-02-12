EpicImages::Application.routes.draw do
  root to: 'home#index'

  get '/about_us', to: 'home#about_us'
  get '/gallery', to: 'home#gallery'
  get '/contact_us', to: 'home#contact_us'
end
