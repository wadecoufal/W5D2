Rails.application.routes.draw do

  resources :comments, only: [:show] do
    resources :comments, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create]
  
  resource :session, only: [:new, :create, :destroy]
  
  resources :subs, except: [:destroy]
  
  resources :posts, except: [:index] do
    resources :comments, only: [:new, :create]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
