Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end 
  resources :charges, only: [:new, :create]

  put 'users/downgrade_user', action: :downgrade, controller: 'users'

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
