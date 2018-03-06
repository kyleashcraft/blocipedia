Rails.application.routes.draw do
  resources :wikis

  resources :charges, only: [:new, :create]

  put 'downgrade_user', action: :downgrade, controller: 'users'

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
