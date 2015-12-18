Rails.application.routes.draw do
  resources :trade_logs
  resources :blogs
  devise_for :users
  root 'home#index'
end
