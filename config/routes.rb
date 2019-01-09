Rails.application.routes.draw do

  resources :skills, except: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home', to: 'home#index', as: 'home'
  
  resources :home, only: [:index]
    root :to => redirect('/home')
    
  resources:courses, shallow: true do
    resources :sections, shallow: true do
      resources :projects, except: [:show]
    end
  end
    get 'courses/:id/remove', to: 'courses#remove', as: 'remove_course'
    
  resources :admins, except: [:show]
    get 'createaccount', to: 'admins#new', as: 'createaccount'
    get 'admin_account', to: 'admins#edit', as:'admin_account'
    get 'admins/:id/remove', to: 'admins#remove', as: 'remove_admin'
    
  resources :sessions, only: [:new, :create, :destroy]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

end