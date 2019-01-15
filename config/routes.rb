Rails.application.routes.draw do
  resources :posts
  root to: 'posts#index'
  resources :home, only: :index
end
