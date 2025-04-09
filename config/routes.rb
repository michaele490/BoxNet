Rails.application.routes.draw do
  devise_for :editor_users, controllers: { registrations: "users/registrations" }
  devise_for :spectator_users, controllers: { registrations: "users/registrations" }
  devise_for :coach_users, controllers: { registrations: "users/registrations" }
  devise_for :boxer_users, controllers: { registrations: "users/registrations" }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Paths
  root "main#index"
  get "/signup", to: "main#sign_up"
  get "/results", to: "main#results"
  get "/fixtures", to: "main#fixtures"
  get "/coach", to: "users/coach_users#assign_boxers", as: :assign_boxers

  # Resources
  namespace :users do
    resources :coach_users do
      get "assign_boxers", on: :collection
      post "assign_boxer", on: :collection
    end
  end

  # These lines allow for sessions to end, i.e, log outs
  devise_scope :boxer_user do
    get "/boxer_users/sign_out" => "devise/sessions#destroy"
  end
  devise_scope :coach_user do
    get "/coach_users/sign_out" => "devise/sessions#destroy"
  end
  devise_scope :spectator_user do
    get "/spectator_users/sign_out" => "devise/sessions#destroy"
  end
  devise_scope :editor_user do
    get "/editor_users/sign_out" => "devise/sessions#destroy"
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
