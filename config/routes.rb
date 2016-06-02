Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resource :session, only: [:create, :destroy, :new] #sessions controller #2
  resources :users, only: [:create, :new] #Users controller #2 
end
