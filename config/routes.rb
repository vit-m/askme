Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :questions
  get 'show', to: 'users#show'
end
