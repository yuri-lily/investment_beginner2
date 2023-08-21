Rails.application.routes.draw do
  get 'opinions/index'
  get 'opinions/new'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'opinions#index'
  resources :opinions

end
