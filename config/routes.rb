Rails.application.routes.draw do
  get 'products/index'
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  namespace :admin do
    resources :products
    resources :promotions
  end

  resources :products, only: [:index]
  resources :basket_items, only: %i[index create destroy]
end
