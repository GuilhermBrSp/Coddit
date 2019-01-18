Rails.application.routes.draw do
  root to: 'posts#index'
  resources :home, only: :index
  resources :posts, only: [:new, :create, :index]
end
