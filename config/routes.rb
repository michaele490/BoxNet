Rails.application.routes.draw do
  devise_for :editors
  #devise_for :spectators
  devise_for :coaches
  devise_for :boxers, controllers: { registrations: 'boxers/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # General Routes
  root "main#index"
  get "/signup", to: "main#sign_up"
  get "/results", to: "main#results"
  get "/fixtures", to: "main#fixtures"
  get "/boxers", to: "main#boxers"
  get "/test", to: "main#test"
  get "/coach_profile", to: "coaches#profile", as: :coach_profile
  get "/assign_boxers", to: "coaches#assign_boxers", as: :assign_boxers

  # Coach Routes
  patch "/update_attributes/:boxer_id", to: "coaches#update_attributes", as: :update_attributes
  post "/send_add_request/:boxer_id", to: "coaches#send_add_request", as: :send_add_request_coach
  delete "/cancel_request/:boxer_id", to: "coaches#cancel_request", as: :cancel_request_coach
  get "/full_results", to: "coaches#full_results", as: :full_results_coach

  # Boxer Routes
  get "/boxer_profile/:id", to: "boxers#profile", as: :boxer_profile
  get "/boxer_details", to: "boxers#details", as: :boxer_details
  get "/edit_boxer_ratings/:boxer_id", to: "coaches#edit_boxer", as: :edit_boxer_ratings
  patch "/update_details", to: "boxers#update_details", as: :update_details_boxer

  # Editor Routes
  get "/manage_fixtures", to: "editors#manage_fixtures"
  get "/manage_results", to: "editors#manage_results"
  get "/fights", to: "editors#fights"

  # Resources
  namespace :users do
    resources :coaches do
      get "assign_boxers", on: :collection
      post "assign_boxer", on: :collection
    end
  end

  # These lines allow for sessions to end, i.e, log outs
  devise_scope :boxer do
    get "/boxers/sign_out" => "devise/sessions#destroy"
  end
  devise_scope :coach do
    get "/coaches/sign_out" => "devise/sessions#destroy"
  end
=begin
  devise_scope :spectator do
    get "/spectators/sign_out" => "devise/sessions#destroy"
  end
=end
  devise_scope :editor do
    get "/editors/sign_out" => "devise/sessions#destroy"
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  resources :boxer_requests, only: [:index] do
    member do
      post :accept
      post :reject
    end
  end

  delete 'boxers/:id/remove', to: 'boxers#remove', as: 'remove_boxer'

  get '/boxers/autocomplete', to: 'boxers#autocomplete'

  resources :fights, only: [:create, :update, :destroy]

  post '/manage_results', to: 'editors#create'
end
