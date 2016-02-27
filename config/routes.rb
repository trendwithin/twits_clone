Rails.application.routes.draw do
  resources :trade_logs
  resources :blogs
  devise_for :users, controllers: { registrations: 'registrations'}
  root 'home#index'
end
