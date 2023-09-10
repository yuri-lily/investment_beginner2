Rails.application.routes.draw do

  devise_for :users

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
