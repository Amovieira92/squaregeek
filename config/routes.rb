Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'perfil', to: 'users#profile' , as: 'my_profile'
  resources :proposals, only: %i[index show]
  resources :products, only: %i[show new create edit update destroy]
end
