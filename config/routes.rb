Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:index,:show,:edit,:update]
  resources :books, :except => :new
  root 'home#index'
  get 'home/about' => 'home#show', as: 'about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
