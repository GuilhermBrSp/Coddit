Rails.application.routes.draw do
  root to: 'posts#index'
  resources :home, only: :index

  resources :posts, only: [:new, :create, :index, :show]

  resources :posts do
    resources :comments, only: [:create]
  end
  resources :comments do
    resources :comments, only: [:create]
  end

  get '/search', to: 'query#search', as: 'button'


end
