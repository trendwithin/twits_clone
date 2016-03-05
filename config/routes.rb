Rails.application.routes.draw do
  resources :trade_logs
  resources :blogs do
    resources :comments
  end
  devise_for :users
  root 'home#index'
end
