Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :admins
    get 'createaccount', to: 'admins#new', as: 'createaccount'
    get 'account_profile', to: 'admins#show', as: 'accountprofile'
end
