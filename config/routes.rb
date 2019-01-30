Rails.application.routes.draw do
  root to: 'posts#index'
  resources :home, only: :index

  resources :posts, only: %i[new create index show]

  resources :posts do
    resources :comments, only: [:create]
  end
  resources :comments do
    resources :comments, only: [:create]
  end

  get '/search', to: 'query#search', as: 'search'
  post'/favorites', to: 'posts#to_favor', as: 'favorites'
end
