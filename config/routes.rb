Rails.application.routes.draw do
  get 'discussions/index'
  resources :posts
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  authenticated do
    root "home#index"
  end

  devise_scope :user do
    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :games, only: %i[new create show] do
    member do
      post :accept
      post :decline
      post :broadcast_code
      post :round_won
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
      put "upvote",   to: "discussions#upvote"
      put "downvote", to: "discussions#downvote"
    end
    resources :posts, only: [:create, :show, :edit, :update, :destroy], module: :discussions
  end

  namespace :admin do
    resources :categories
  end

  resources :categories, only: [:index, :show]
  resources :users,      only: %i[index show], param: :slug
  resources :challenges, only: %i[index show], param: :name
  get  'challenges/:room_id/:name', to: 'challenges#room', as: :challenge_room
  post 'evaluate_code', to: 'code_evaluations#evaluate'
  post 'hints',         to: 'hints#create'

  get 'home', to: 'home#index', as: 'home'

  namespace :admin do
    get  'settings', to: 'settings#show',   as: 'settings'
    post 'settings', to: 'settings#update'
  end
end
