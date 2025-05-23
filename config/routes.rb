Rails.application.routes.draw do
  get 'discussions/index'
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

  devise_scope :user do
    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :invitations, only: [:index, :create] do
    member do
      post :accept
      post :decline
    end
  end
  resources :notifications, only: [:index]
  resources :discussions, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      put "upvote", to: "discussions#upvote"
      put "downvote", to: "discussions#downvote"
    end
    resources :posts, only: [:create, :show, :edit, :update, :destroy], module: :discussions
  end
  resources :categories
  resources :users, only: %i[index show], param: :slug
  resources :challenges, only: %i[index show], param: :name
  get 'challenges/:room_id/:name', to: 'challenges#room', as: :challenge_room
  post 'evaluate_code', to: 'code_evaluations#evaluate'
end
