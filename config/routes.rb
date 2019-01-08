Rails.application.routes.draw do

  resources :skills
    # get 'skills/create', to: 'skills#create', as: 'skills/create'
    # get 'skills/destroy'
    # get 'skills/new'


  #   get 'skills', to 'skills#new', as: 'skills'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get 'home', to: 'home#index', as: 'home'
  resources :home, only: [:index]
    root :to => redirect('/home')
    
  resources:courses
  
  resources :admins, except: [:show]
    get 'createaccount', to: 'admins#new', as: 'createaccount'
    get 'admin_account', to: 'admins#edit', as:'admin_account'
    
  resources :sessions, only: [:new, :create, :destroy]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :projects
end