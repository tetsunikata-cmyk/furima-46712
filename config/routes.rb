Rails.application.routes.draw do
 
  get "up" => "rails/health#show", as: :rails_health_check
  
  root "items#index"
  resources :items, only: :index
  # Defines the root path route ("/")
  # root "posts#index"
end
