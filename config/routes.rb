Rails.application.routes.draw do

  get 'home', to: 'home#index', as: 'home'
  root :to => redirect('/home')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources:courses
  
  resources :admins
    get 'createaccount', to: 'admins#new', as: 'createaccount'
    get 'account_profile', to: 'admins#show', as: 'accountprofile'
    
  resources :sessions, only: [:new, :create, :destroy]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
end
