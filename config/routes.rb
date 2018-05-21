Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "users#new"

  get "/register", to: "users#new"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:show, :create, :edit, :update]
  
  resources :categories, only: [:index] do
    resources :recipes, only: [:index]
  end

  resources :recipes, only: [:new, :create, :edit, :show, :update, :destroy]
  get "/my_recipes", to: "recipes#my_recipes"
end
