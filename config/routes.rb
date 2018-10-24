Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'perfil', to: 'users#profile' , as: 'my_profile'
  resources :proposals, only: %i[index show] do
    post 'accept', to: 'proposals#accept', as: 'accept'
  end
  resources :products do
    resources :proposals, only: %i[new create]
  end
end
