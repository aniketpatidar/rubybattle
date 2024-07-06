Rails.application.routes.draw do
  get 'home/index'
  resources :posts
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  authenticated  do
    root "pages#dashboard"
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
  get "dashboard", to: "home#index"
  post 'execute_ruby', to: 'ruby_execution#execute'
  get "/:slug", to: "profile#show"
end
