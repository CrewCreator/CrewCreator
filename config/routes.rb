Rails.application.routes.draw do

  resources :skills, except: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get 'home', to: 'home#index', as: 'home'
  resources :home, only: [:index]
    root :to => redirect('/home')
    
  resources:courses, shallow: true do
    resources :sections, shallow: true do
      resources :projects
    end
  end
  
  resources :admins, except: [:show]
    get 'createaccount', to: 'admins#new', as: 'createaccount'
    get 'admin_account', to: 'admins#edit', as:'admin_account'
    get 'remove_admin', to: 'admins#remove', as: 'remove_admin'
    post 'remove_admin_destroy', to: 'admins#destroy', as: 'remove_admin_destroy'
    
  resources :sessions, only: [:new, :create, :destroy]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

end