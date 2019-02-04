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
  post'/favorites/add', to: 'posts#add_favorite', as: 'add_favorite', defaults: { format: 'js'}
  delete'/favorites/remove', to: 'posts#remove_favorite', as: 'remove_favorite', defaults: { format: 'js'}
  get "subscriptions/new" => 'tags#subscribe', as: 'subscribe', defaults: { format: 'js'}
  post "subscriptions/new/confirm" => 'tags#create_subscription', as: 'create_subscription', defaults: { format: 'js'}
end
