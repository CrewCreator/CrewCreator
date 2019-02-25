Rails.application.routes.draw do

  resources :skills, except: [:show]
  resources :sections do
    get 'sections/import'
    collection {post :import}
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home', to: 'home#index', as: 'home'
  
  resources :home, only: [:index]
    root :to => redirect('/home')
    
  resources:courses, shallow: true do
    resources :sections, shallow: true do
      resources :projects, shallow: true, except: [:show] do
        resources :teams, except: [:index]
      end
    end
  end
    get 'sections/:id/remove', to: 'sections#remove', as: 'remove_section'
    get 'courses/:id/remove', to: 'courses#remove', as: 'remove_course'
    get 'projects/:id/remove', to: 'projects#remove', as: 'remove_project'
    get 'teams/:id/remove', to: 'teams#remove', as: 'remove_team'
    
    get 'sections/:section_id/teams', to: 'teams#index', as: 'section_teams'
    get 'sections/:section_id/roster', to: 'sections#roster', as: 'section_roster'
    patch 'sections/:section_id/update_roster', to: 'sections#update_roster'
    post 'sections/:section_id/join', to: 'sections#join', as: 'section_join'
    patch 'sections/:section_id/leave', to: 'sections#leave', as: 'section_leave'
    #post 'sections/:section_id/import', to: 'sections#import', as: 'section_import'
    
  resources :admins, except: [:show]
    get 'admin_account', to: 'admins#edit', as:'admin_account'
    post 'admin_account', to: 'admins#update', as: 'update_admin'
    get 'admins/:id/remove', to: 'admins#remove', as: 'remove_admin'
    
  resources :instructors
    get 'instructors/:id/remove', to: 'instructors#remove', as: 'remove_instructor'
    post 'instructors/:id', to: 'instructors#update', as: 'update_instructor'
    
  resources :students, except: [:show]
    get 'createaccount', to: 'students#new', as: 'createaccount'
    post 'students/:id', to: 'students#update', as: 'update_student'
    get 'students/:id/remove', to: 'students#remove', as: 'remove_student'
    
  resources :sessions, only: [:new, :create, :destroy]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

end