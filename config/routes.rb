Rails.application.routes.draw do
  get 'wiki/index'

  get 'wiki/show'

  get 'wiki/new'

  get 'wiki/edit'

  get 'wiki/create'

  get 'wiki/read'

  get 'wiki/update'

  get 'wiki/delete'

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
