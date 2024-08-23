Rails.application.routes.draw do
  get 'discussions/index'
  get 'home/index'
  resources :posts
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  authenticated  do
    root "discussions#index"
  end

  unauthenticated do
    root "pages#home", as: :unauthenticated_root
  end
  resources :invitations, only: [:index, :create] do
    member do
      post :accept
      post :decline
    end
  end
  get "practice/:room_id", to: "home#index", as: "practice"
  post 'execute_ruby', to: 'ruby_execution#execute'
  resources :notifications, only: [:index]
  resources :discussions, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      put "upvote", to: "discussions#upvote"
      put "downvote", to: "discussions#downvote"
    end
    resources :posts, only: [:create, :show, :edit, :update, :destroy], module: :discussions
  end
  resources :categories
  get "users", to: "pages#dashboard"
  get "/:slug", to: "profile#show"
end
