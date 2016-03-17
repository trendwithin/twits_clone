Rails.application.routes.draw do
  get 'timeline' => 'static_pages#timeline'

  resources :trade_logs
  resources :blogs do
    resources :comments
  end
  devise_for :users
  root 'home#index'
end
