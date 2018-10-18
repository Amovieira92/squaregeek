Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'perfil', to: 'users#profile' , as: 'my_profile'
  resources :products only: [:new, :create, :show, :edit, :update]
end
