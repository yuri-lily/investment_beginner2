Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'opinions#index'

  resources :opinions do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: :show do
    resources :favorites, only: [:new, :create, :update, :destroy]  do
      member do
        put :price_and_profit
      end
    end
  end

  post 'search_stock_data', to: 'opinions#search_stock_data', as: :search_stock_data
  
end
