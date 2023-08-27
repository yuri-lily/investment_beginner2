Rails.application.routes.draw do
  #get 'opinions/index'消すかも
  #get 'opinions/new'消すかも
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'opinions#index'

  resources :opinions do
    resources :comments, only: :create
  end

  resources :users, only: :show
  
end
